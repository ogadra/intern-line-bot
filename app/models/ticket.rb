class Ticket < ApplicationRecord
  belongs_to :user

  validates [:code, :url], uniqueness: true
  validates [:code, :brand_id, :item_id, :url, :status, :issued_at, :line_user_id], presence: true
  
end
