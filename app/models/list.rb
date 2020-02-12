class List < ApplicationRecord
  belongs_to :user
    #数字のみを許可
    validates :expense, presence: true, numericality: true
    
    #英語・数字のみの入力を許可する
    validates :place, presence: true, length: { maximum: 255 }, format: { with: /\A[A-Za-z0-9\s]*\z/, allow_blank: true }
    validates :item_name, presence: true, length: { maximum: 255 }, format: { with: /\A[A-Za-z0-9\s]*\z/, allow_blank: true }
    validates :category, presence: true, format: { with: /\A[A-Za-z][A-Za-z0-9]*\z/, allow_blank: true }
end
