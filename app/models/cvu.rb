class Cvu < ApplicationRecord
    validates :name, length: { minimum: 4 }
    validates :digits, length: { is: 22 }, format: {with: /\A[+-]?\d+\z/}, uniqueness: true
    validates :alias, length: { minimum: 6, maximum: 20}, uniqueness: true
    belongs_to :billetera
end
