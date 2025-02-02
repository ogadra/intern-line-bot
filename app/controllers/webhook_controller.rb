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
        request_line_user_id = event['source']['userId']

        User.register(request_line_user_id, timestamp_datetime)
        begin
          res = GajoenApi.create_tickets(145,56509)
          Ticket.add(res['code'], res['brand_id'], res['item_id'], res['url'], res['status'], res['issued_at'], res['exchanged_at'], request_line_user_id)
          message = {
            type: 'text',
            text: '友達登録ありがとうございます！感謝の気持ちを込めて、クーポンをお送りいたします。是非ご活用ください！' + res['url']
          }
        rescue
          message = {
            type: 'text',
            text: '友達登録ありがとうございます！'
          }
        end
        client.reply_message(event['replyToken'], message)

      when Line::Bot::Event::Unfollow
        User.find_by(line_user_id: event['source']['userId']).archive
      end
    }
    head :ok
  end
end
