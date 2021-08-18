class User < ApplicationRecord
  validates :line_user_id, presence: true, uniqueness: true
  validates :friend_registration_datetime, presence: true
end
