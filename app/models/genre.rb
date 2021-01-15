class Genre < ApplicationRecord

  has_many :items, dependent: :destroy

  validates :name, presence: true
  validates :is_active, presence: true

end
