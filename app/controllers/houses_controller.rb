# frozen_string_literal: true

class HousesController < ApplicationController
  before_action :set_house, only: %i[show edit update destroy]
  load_and_authorize_resource
  def new
    @house = House.new
  end

  def create
    @house = House.new(house_params)
    if @house.save
      flash[:notice] = 'House created'
      redirect_to @house
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @house.update(house_params)
      flash[:notice] = 'House updated'
      redirect_to @house
    else
      render 'edit'
    end
  end

  def index
    @houses = House.all
  end

  private

  def set_house
    @house = House.find(params[:id])
  end

  def house_params
    params.require(:house).permit(:sales_name, :build_number, :bedrooms)
  end
end
