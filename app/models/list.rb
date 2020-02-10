class List < ApplicationRecord
  belongs_to :user
    validates :expense, presence: true, numericality: true
    validates :place, presence: true, length: { maximum: 255 }
    validates :item_name, presence: true, length: { maximum: 255 }
end
