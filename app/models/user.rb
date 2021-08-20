class User < ApplicationRecord
  has_many :tickets, foreign_key: :line_user_id
  self.primary_key = :line_user_id

  validates :line_user_id, presence: true, uniqueness: true
  validates :friend_registration_datetime, presence: true

  def self.register(line_user_id, datetime)
    existed_user = User.find_or_create_by(line_user_id: line_user_id) do |user|
      user.friend_registration_datetime = datetime
    end
    existed_user.update(is_blocked: false)
  end

  def archive
    self.update(is_blocked: true)
  end
end
