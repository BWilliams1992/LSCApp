# frozen_string_literal: true

class PlotsController < ApplicationController
  before_action :set_plot, only: %i[show edit update]
  before_action :set_location, only: %i[show edit update]
  load_and_authorize_resource
  def create
    @plot = Plot.new(plot_params)
    @plot.save
  end

  def show; end

  def edit; end

  def update
    if @plot.update(plot_params)
      flash[:notice] = "Plot successfully updated"
      redirect_to location_plot_path(@location,@plot) 
    else 
      render 'edit'
    end
  end

  private

  def plot_params
    params.require(:plot).permit(:number, :location_id, :house_id)
  end

  def set_plot
    @plot = Plot.find(params[:id])
  end

  def set_location
    @location = Location.find(params[:location_id])
  end
end
