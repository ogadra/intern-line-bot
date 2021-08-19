class User < ApplicationRecord
  validates :line_user_id, presence: true, uniqueness: true
  validates :friend_registration_datetime, presence: true

  def register(line_user_id, datetime)
    existed_user = User.find_or_create_by(line_user_id: line_user_id) do |user|
      user.friend_registration_datetime = datetime
    end
    existed_user.update(is_blocked: false)

  end

  def archive(user_id)
    @user = User.find_by(line_user_id: user_id)
    @user.update(is_blocked: true )
  end
end
