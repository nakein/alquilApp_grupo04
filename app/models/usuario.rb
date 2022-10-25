class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :fullname, :dni, :birthdate, presence: true

  has_one_attached :license
  has_one :billetera

  enum role: [:cliente, :supervisor, :administrador]
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :cliente
    self.billetera ||= Billetera.new
  end
end
