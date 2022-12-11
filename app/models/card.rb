class Card < ApplicationRecord
validates :name, length: { minimum: 4 }
validates :digits, length: { is: 20 }, format: {with: /\A[+-]?\d+\z/}, uniqueness: true
validates :security_code, length: { is: 3 }, format: {with: /\A[+-]?\d+\z/}
validates :exp_date, presence: true
validates :money, presence: true
enum card_type: [:debito, :visa, :mastercard]
after_initialize :set_default_card_type, :if => :new_record?
  def set_default_card_type
    self.card_type ||= :debito
  end
belongs_to :billetera
end
