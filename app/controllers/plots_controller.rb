class PlotsController < ApplicationController

  def create 
    @plot = Plot.new(plot_params)
    @plot.save
  end

  private

    def plot_params
      params.require(:plot).permit(:number)
    end

end
