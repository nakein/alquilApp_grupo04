class VehiculosController < ApplicationController
  def create
    @vehiculo = Vehiculo.new(vehicle_params)

    if @vehiculo.save
      redirect_to vehiculos_index_path, notice: "Vehículo agregado satisfactoriamente"
    else
      render :new
    end
  end

  private

    def vehicle_params
      params.require(:vehiculo).permit(:image, :brand, :model, :color, :fuel_type, :capacity, :transmission)
    end
end
