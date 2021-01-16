class Address < ApplicationRecord

  belongs_to :customer

  validates :customer_id, presence: true
  validates :name, presence: true
  validates :postal_code, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/}
  validates :address, presence: true

  def registration_address_info
    return "〒#{self.postal_code}　#{self.address}　#{self.name}"
  end

end
