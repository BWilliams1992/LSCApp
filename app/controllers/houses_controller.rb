class HousesController < ApplicationController
    before_action :set_house, only: [:show,:edit,:update,:destroy]
        def new
            @house = House.new
        end
    
        def create
            @house =  House.new(house_params)
            if @house.save 
                flash[:notice] = "House created"
                redirect_to @house
            else 
                render 'new'
            end
        end
    
        def show
        end
    
        def index
            @houses = House.all
        end
    
        private
    
            def set_house
                @house = House.find(params[:id])
            end
    
            def house_params
                params.require(:house).permit(:sales_name, :build_number, :cost)
            end
    
    end
    