class VehiculosController < ApplicationController
  def index
    @vehiculos = Vehiculo.all
  end

  def new
  end

  def show
    @vehiculo = Vehiculo.find(params[:id])
  end

  def edit
    @vehiculo = Vehiculo.find(params[:id])
  end

  def update
    @vehiculo = Vehiculo.find(params[:id])

    if @vehiculo.update(vehicle_params)
      redirect_to vehiculos_path, notice: "El vehiculo fue actualizado"
    else
      render :edit
    end
  end

  def create
    @vehiculo = Vehiculo.new(vehicle_params)

    if @vehiculo.save
      redirect_to vehiculos_path, notice: "Vehiculo agregado satisfactoriamente"
    else
      render :new
    end
  end

  def destroy
      @vehiculo = Vehiculo.find(params[:id])
      @vehiculo.destroy
      redirect_to vehiculos_path, notice: "Vehiculo eliminado satisfactoriamente"
  end

  private

    def vehicle_params
      params.require(:vehiculo).permit(:image, :brand, :model, :color, :fuel_type, :capacity, :transmission)
    end
end
