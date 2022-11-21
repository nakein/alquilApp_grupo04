class EstadoController < ApplicationController
def mi_estado
    @alquiler = Alquiler.where(user_id: current_usuario.id).last
    render "mi_estado"
end

end
