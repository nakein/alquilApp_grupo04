class Report < ApplicationRecord
    belongs_to:usuario
    enum status: [:esperando, :realizado]
end
