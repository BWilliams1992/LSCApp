class PlotsController < ApplicationController
  before_action :set_plot, only:[:show,:edit,:update]
  before_action :set_location, only:[:show,:edit,:update]
  def create 
    @plot = Plot.new(plot_params)
    @plot.save
  end

  def show
  end

  def edit
  end

  def update
    if @plot.update(plot_params)
      redirect_to @location
    end
  end

  private

    def plot_params
      params.require(:plot).permit(:number, :location_id, :house_id )
    end

    def set_plot
      @plot = Plot.find(params[:id])
    end

    def set_location
      @location = Location.find(params[:location_id])
    end

end
