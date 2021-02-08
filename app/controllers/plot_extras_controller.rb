# frozen_string_literal: true

class PlotExtrasController < ApplicationController
  before_action :set_plot_extra, only: %i[show edit update destroy]
  before_action :set_location, :set_plot
  def index
    @plot_extras = PlotExtra.all
  end

  def show; end

  def new
    @plot_extra = PlotExtra.new
  end

  def create
    @plot_extra = PlotExtra.new(plot_extra_params)
    @plot_extra.plot = @plot
    if @plot_extra.save!
      redirect_to location_plot_path(@location, @plot)
    else
      render 'new'
    end
  end

  def edit; end

  private

  def plot_extra_params
    params.require(:plot_extra).permit(:plot_id, :extra_id)
  end

  def set_plot
    @plot = Plot.find(params[:plot_id])
  end

  def set_location
    @location = Location.find(params[:location_id])
  end

  def set_plot_extra
    @plot_extra = PlotExtra.find(params[:id])
  end
end
