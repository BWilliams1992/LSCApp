# frozen_string_literal: true

class CleansController < ApplicationController
  before_action :set_clean, only: %i[show edit update destroy]
  load_and_authorize_resource
  require "google/apis/Calendar_v3"
  require 'google/api_client/client_secrets'

  def new
    @clean = Clean.new
  end

  def create
    @clean = Clean.new(clean_params)

    calendar = Google::Apis::CalendarV3::CalendarService.new

    

    calendar.authorization = session["auth_client"]
    byebug
    event = Google::Apis::CalendarV3::Event.new(
      location: @clean.stringify_address,
      description: @clean.clean_type,
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: @clean.date,
        time_zone: 'GMT/London'
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: @clean.date,
        time_zone: 'GMT/London'
      )
    )
    byebug
    calendar.insert_event('primary', event)

    if @clean.save!
      flash[:notice] = 'Clean was succesfully created!'
      # redirect_to @clean
    else
      render 'new'
    end
  end

  def show; end

  def index
    @cleans = Clean.all
  end

  def update
    if @clean.update!(clean_params)
      flash[:notice] = 'Clean successfully updated!'
      redirect_to @clean
    else
      render 'edit'
    end
  end

  def edit; end

  def destroy
    @clean.destroy
    flash[:notice] = 'Clean removed'
    redirect_to cleans_path
  end

  private

  def set_clean
    @clean = Clean.find(params[:id])
  end

  def clean_params
    params.require(:clean).permit(:date, :location_id, :plot_id, :completed, :clean_type, :clean_request,
                                  :start_time, :end_time, :num_people)
  end
end
