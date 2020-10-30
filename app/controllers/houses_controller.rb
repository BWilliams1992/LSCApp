class HousesController < ApplicationController
    before_action :set_house, only: [:show,:edit,:update,:destroy]
    before_action :set_location, only: [:new, :index]
        def new
            @house = House.new
        end
    
        def create
            @location = Location.find(params[:location_id])
            @house =  @location.houses.create(house_params)
            if @house.save 
                flash[:notice] = "House created"
                redirect_to location_house_path(@location, @house)
            else 
                render 'new'
            end
        end
    
        def show
        end
    
        def index
        end
    
        private
    
            def set_house
                @house = House.find(params[:id])
            end

            def set_location
                @location = Location.find(params[:location_id])
            end
    
            def house_params
                params.require(:house).permit(:sales_name, :build_number, :cost)
            end
    
    end
    