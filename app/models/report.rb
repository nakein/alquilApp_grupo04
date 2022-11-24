class Report < ApplicationRecord
    belongs_to:usuario
    enum status: [:"en espera", :realizado]
end
