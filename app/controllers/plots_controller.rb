class PlotsController < ApplicationController
  before_action :set_plot, only:[:show]
  def create 
    @plot = Plot.new(plot_params)
    @plot.save
  end

  def show
  end

  private

    def plot_params
      params.require(:plot).permit(:number)
    end

    def set_plot
      @plot = Plot.find(params[:id])
    end

end
