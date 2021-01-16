class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_items, dependent: :destroy

  validates :customer_id, presence: true
  validates :payment_method, presence: true
  validates :total_price, presence: true
  validates :postage, presence: true
  validates :status, presence: true
  validates :name, presence: true
  validates :postal_code, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
  validates :address, presence: true

  enum payment_method: {
    credit: 0,
    bank: 1
  }

  enum status: {
    "入金待ち": 0,
    "入金確認": 1,
    "製作中": 2,
    "発送準備中": 3,
    "発送済み": 4
  }

end