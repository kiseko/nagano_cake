class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_items, dependent: :destroy

  enum genre:{
    credit: 0, #クレジットカード
    bank: 1,  #銀行振込
  }

end
