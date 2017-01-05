class RidesController < ApplicationController
  before_action :set_ride, only: [:show, :update, :destroy]

  def index
    @rides = Ride.all

    render json: @rides
  end

  def show
    render json: @ride
  end

  def create
    @ride = Ride.new(ride_params)

    if @ride.save
      render json: @ride, status: :created, location: @ride
    else
      render json: @ride.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rides/1
  def update
    if @ride.update(ride_params)
      render json: @ride
    else
      render json: @ride.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rides/1
  def destroy
    @ride.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ride
      @ride = Ride.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ride_params
      params.require(:ride).permit(:driver_id, :from_city_id, :from_neighborhood_id, :from_description, :to_city_id, :to_neighborhood_id, :to_description, :start_at, :end_at, :status, :description)
    end
end
