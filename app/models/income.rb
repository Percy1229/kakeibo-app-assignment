class Income < ApplicationRecord
  belongs_to :user
  
  #数字のみを許可
    validates :income, presence: true, numericality: true
    
    #英語・数字のみの入力を許可する
    validates :source, presence: true,
    format: { with: /\A[A-Za-z][A-Za-z0-9]*\z/, allow_blank: true }
end
