require 'line/bot'

class WebhookController < ApplicationController
  protect_from_forgery except: [:callback] # CSRF対策無効化

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head 470
    end

    events = client.parse_events_from(body)
    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: event.message['text']
          }
          client.reply_message(event['replyToken'], message)
        when Line::Bot::Event::MessageType::Image, Line::Bot::Event::MessageType::Video
          response = client.get_message_content(event.message['id'])
          tf = Tempfile.open("content")
          tf.write(response.body)
        end

      when Line::Bot::Event::Follow
        timestamp_datetime = Time.at(event['timestamp']/1000)

        new_line_user_id = event['source']['userId']
        exists_user_id = User.find_by(line_user_id: new_line_user_id)
        if exists_user_id then
          exists_user_id.update(is_blocked: false)
          User.create(line_user_id: new_line_user_id, friend_registration_datetime: timestamp_datetime, is_blocked: false)
        else
          User.create(line_user_id: new_line_user_id, friend_registration_datetime: timestamp_datetime, is_blocked: false)
        end

        message = {
          type: 'text',
          text: '友達登録ありがとうございます！'
        }
        client.reply_message(event['replyToken'], message)
      when Line::Bot::Event::Unfollow

        block_line_user_id = event['source']['userId']
        user = User.find_by(line_user_id: block_line_user_id)
        user.update(is_blocked: true )
      end
    }
    head :ok
  end
end
