class RidesController < ApplicationController

  def index
    rides = Ride.all

    #send_push_notification(@current_user, 'Teste')

    render json: rides.as_json( only: [:id, :description, :from_description, :to_description, :start_at, :end_at, :ride_type],
                                include: {   
                                          from_city: { only: [:name, :slug]},
                                          from_neighborhood: { only: [:name]},
                                          to_city: { only: [:name, :slug]},
                                          to_neighborhood: { only: [:name]},
                                          driver: { only: [:name] }
                                        })
  end

  def show
    render json: Ride.find(params[:id]).as_json( only: [:id, :description, :from_description, :to_description, :start_at, :end_at, :ride_type],
                                include: {   
                                          from_city: { only: [:name, :slug]},
                                          from_neighborhood: { only: [:name]},
                                          to_city: { only: [:name, :slug]},
                                          to_neighborhood: { only: [:name]},
                                          driver: { only: [:name] }
                                        })
  end

  def create
    ride = Ride.new
    ride.ride_type               = params[:type]
    ride.to_city            = City.new_city(params[:to_city_name])
    ride.to_neighborhood    = Neighborhood.new_neighborhood(params[:to_neighborhood_name], ride.to_city.id)
    ride.to_description     = params[:to_description]
    ride.from_city          = City.new_city(params[:from_city_name]) 
    ride.from_neighborhood  = Neighborhood.new_neighborhood(params[:from_neighborhood_name], ride.from_city.id) 
    ride.from_description   = params[:from_description]
    ride.description        = params[:description]
    ride.start_at           = DateTime.strptime(params[:date] + ' ' + params[:start_time], '%d/%m/%Y %H:%M')
    ride.end_at             = DateTime.strptime(params[:date] + ' ' + params[:end_time], '%d/%m/%Y %H:%M')
    ride.driver             = User.find_by(token: params[:token])
    ride.status             = 'active'
    if ride.save
      render json: ride, status: :created, location: ride
    else
      render json: ride.errors, status: :unprocessable_entity
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
    def set_ride
      @ride = Ride.find(params[:id])
    end

    def ride_params
      params.require(:ride).permit(:token, :from_city_name, :from_neighborhood_name, :from_description, 
                                    :to_city_name, :to_neighborhood_name, :to_description,
                                    :start_at, :end_at, :status, :description)
    end
end
