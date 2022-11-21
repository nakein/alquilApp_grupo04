class Alquiler < ApplicationRecord
    enum status: [:en_curso, :completado, :fin_reciente, :cancelado]
    after_initialize :set_default_status, :if => :new_record?
    def set_default_status
        self.status ||= :en_curso
    end
end
