class CostHouseLocationsController < ApplicationController
  before_action :set_cost_house_location, only:[:show,:edit,:update]
  before_action :set_location, only:[:show, :new, :create, :edit, :update]
  def new
    @cost_house_location = CostHouseLocation.new
  end

  def create 
    @cost_house_location = CostHouseLocation.new(cost_house_location_params)
    if @cost_house_location.save!
      redirect_to @cost_house_location.location
    else
      render 'new'
    end
  end

  def show
  end

  def index 
    @cost_house_locations = CostHouseLocation.all
  end

  def edit 
  end

  def update

  end

  def destroy

  end



  private

    def cost_house_location_params 
      params.require(:cost_house_location).permit(:cost, :house_id, :location_id)
    end

    def set_cost_house_location
      @cost_house_location = CostHouseLocation.find(params[:id])
    end

    def set_location
      @location = Location.find(params[:location_id])
    end

end
