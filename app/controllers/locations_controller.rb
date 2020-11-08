class LocationsController < ApplicationController
    before_action :set_location, only: [:show,:edit,:update,:destroy]

    def new
        @location = Location.new 
    end

    def create 
        @location = Location.new(location_params)
        @location.user_id = current_user.id 
        @plots = params[:location][:number_of_plots].to_i
        for i in 1..@plots do
            @location.plots.build(number: i)
        end
        if @location.save 
            flash[:notice] = "Location successfully created"
            redirect_to @location
        else
            render 'new'
        end
    end

    def show
    end

    def update
        if @location.update(location_params)
            flash[:notice] = "Location successfully updated!"
            redirect_to @location
        else 
            render 'edit'
        end
    end

    def edit
    end

    def destroy
        @location.destroy
        flash[:notice] = "Location Deleted"
        redirect_to locations_path
    end

    def index
        @locations = Location.all
    end

    private

        def set_location 
            @location = Location.find(params[:id])
        end

        def location_params
            params.require(:location).permit(:site_name, :address1, :address2, :city, :county, :postcode, :user_id, :number_of_plots)
        end
end
