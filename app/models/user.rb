class User < ApplicationRecord
  validates :user_id, presence: true, uniqueness: true
  validates :timestamp, presence: true
end
