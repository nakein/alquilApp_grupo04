class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :lockable

  validates :birthdate, presence: true
  validates :dni, uniqueness: true, presence: true
  validates :fullname, presence: true, format: { with: /\A[a-z A-Zñ]+\z/,
    message: "solo admite letras" }
  validate :correct_license_type

  has_one_attached :license
  has_one :billetera

  enum role: [:cliente, :supervisor, :administrador]
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :cliente
    self.billetera ||= Billetera.new
  end

  private
    def correct_license_type
      if license.attached? && !license.content_type.in?(%w(image/jpg image/jpeg image/png))
        license.purge # delete the uploaded file
        errors.add(:license, 'debe ser una imagen')
      end
    end
end
