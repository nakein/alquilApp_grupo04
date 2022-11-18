class Vehiculo < ApplicationRecord
  validates :brand, :model, presence:true
  validates :color, :fuel_type, :transmission, presence: true, format: { with: /\A[a-z A-Zñ]+\z/,
    message: "solo admite letras" }
  validates :capacity, presence: true
  validates :license_plate, presence:true, uniqueness: true, format: { with: /\A[A-Z]{2}[0-9]{3}[A-Z]{2}\z|\A[A-Z]{3}[0-9]{3}\z/, message: "inválida"}
  

  has_one_attached :image

  validate :correct_image_type

  private
  def correct_image_type
    if image.attached? && !image.content_type.in?(%w(image/jpg image/jpeg image/png))
      image.purge # delete the uploaded file
      errors.add(:image, 'debe ser una imagen')
    end
  end

end
