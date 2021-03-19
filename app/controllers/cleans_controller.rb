# frozen_string_literal: true

require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets'

class CleansController < ApplicationController
  before_action :set_clean, only: %i[show edit update destroy]

  rescue_from Google::Apis::AuthorizationError, with: :unauthorized
  
  load_and_authorize_resource

  def new
    @clean = Clean.new
  end

  def create
    @clean = Clean.new(clean_params)
    if @clean.save!
      client = get_google_calendar_client current_user
      clean = @clean
      event = get_event clean
      client.key = ENV['GOOGLE_API_KEY']
      client.insert_event('f6bqtf9impi8637ecd7kbn5vbk@group.calendar.google.com', event)
      flash[:notice] = 'Clean was succesfully created!'
      redirect_to @clean
    else
      render 'new'
    end
  end

  def get_google_calendar_client(current_user)
    client = Google::Apis::CalendarV3::CalendarService.new
    return unless current_user.present? && current_user.access_token.present? && current_user.refresh_token.present?

    secrets = Google::APIClient::ClientSecrets.new({
                                                     'web' => {
                                                       'access_token' => current_user.access_token,
                                                       'refresh_token' => current_user.refresh_token,
                                                       'client_id' => ENV['GOOGLE_API_KEY'],
                                                       'client_secret' => ENV['GOOGLE_CLIENT_SECRET']
                                                     }
                                                   })

    begin
      client.authorization = secrets.to_authorization
      client.authorization.grant_type = 'refresh_token'
      unless current_user.present?
        client.authorization.refresh!
        current_user.update_attributes(
          access_token: client.authorization.access_token,
          refresh_token: client.authorization.refresh_token,
          expires_at: client.authorization.expires_at.to_i
        )
      end
    rescue Google::Apis::AuthorizationError
      flash[:error] = 'Your token has been expired. Please login again with google.'
      redirect_to :back
    end
    client
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

  def unauthorized
    flash[:error] = 'Your token has been expired. Please login again with google.'
    redirect_to user_google_oauth2_omniauth_authorize_path
  end

  def get_event(clean)
    start_date_time = clean.date.to_time + (clean.start_time.hour * 60 * 60) if clean.start_time

    end_date_time = clean.date.to_time + (clean.end_time.hour * 60 * 60) if clean.end_time

    event = Google::Apis::CalendarV3::Event.new({
                                                  start: {
                                                    date_time: clean.start_time ? start_date_time.rfc3339 : clean.date.rfc3339,
                                                    time_zone: 'Europe/London'
                                                  },
                                                  end: {
                                                    date_time: clean.end_time ? end_date_time.rfc3339 : clean.date.rfc3339,
                                                    time_zone: 'Europe/London'
                                                  },
                                                  summary: clean.clean_type,
                                                  location: clean.stringify_address,
                                                  description: clean.clean_type + ' at ' + clean.location.site_name + ' Plot ' + clean.plot.number.to_s
                                                })
  end
end
