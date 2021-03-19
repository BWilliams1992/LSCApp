# frozen_string_literal: true

class ExtrasController < ApplicationController
  before_action :set_extra, only: %i[show edit update destroy]
  load_and_authorize_resource
  def new
    @extra = Extra.new
  end

  def create
    @extra = Extra.new(extra_params)
    if @extra.save
      flash[:notice] = 'Extra created'
      redirect_to @extra
    else
      render 'new'
    end
  end

  def show; end

  def index
    @extras = Extra.all
  end

  def edit; end

  def update
    if @extra.update(extra_params)
      flash[:notice] = 'Extra updated'
      redirect_to @extra
    else
      render 'edit'
    end
  end

  def destroy; end

  private

  def set_extra
    @extra = Extra.find(params[:id])
  end

  def extra_params
    params.require(:extra).permit(:name, :cost)
  end
end
