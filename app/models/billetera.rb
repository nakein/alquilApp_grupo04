class Billetera < ApplicationRecord

    validates :saldo, presence: true
    belongs_to :usuario
    has_one :compra
end
    
    