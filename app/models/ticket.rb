class Ticket < ApplicationRecord
  belongs_to :user, foreign_key: :line_user_id, optional: true
  #userにnilを許容する

  validates :code, :url, uniqueness: true
  validates :code, :brand_id, :item_id, :url, :status, :issued_at, :line_user_id, presence: true

  def self.add(code, brand_id, item_id, url, status, issued_at, exchanged_at, line_user_id)
    Ticket.new(
      code: code,
      brand_id: brand_id,
      item_id: item_id,
      url: url,
      status: status,
      issued_at: issued_at,
      exchanged_at: exchanged_at,
      line_user_id: line_user_id
    ).save!

  end
end
