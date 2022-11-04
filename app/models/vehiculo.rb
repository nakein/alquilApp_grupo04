class Vehiculo < ApplicationRecord
    validates :brand, :model, :color, :fuel_type, :capacity, :transmission, presence: true

    has_one_attached :image
end
