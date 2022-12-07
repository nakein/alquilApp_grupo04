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

    copy = @vehiculo.dup
    copy.image.attach(@vehiculo.image.blob)
    if @vehiculo.update(vehicle_params)
      redirect_to vehiculos_path, notice: "El vehiculo fue actualizado"
    else
      @vehiculo.image.attach(copy.image.blob)
      render :edit
    end
  end

  def create
    @vehiculo = Vehiculo.new(vehicle_params)
    @vehiculo.latitude = (-34.904 + rand(-0.0059..0.0059)).truncate(4)
    @vehiculo.longitude = (-57.937 + rand(-0.0059..0.0059)).truncate(4)
    @vehiculo.proximity = (Geocoder::Calculations.distance_between(@vehiculo,[-34.9213, -57.9545], units: :km)).truncate(1)

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
      params.require(:vehiculo).permit(:image, :brand, :model, :license_plate, :color, :fuel_type, :capacity, :transmission)
    end
end
