class Compra < ApplicationRecord

    validates :medio_de_pago, presence: true
    validates :monto, comparison: {greater_than_or_equal_to: 0.0}
    belongs_to :billetera

end