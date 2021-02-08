# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  login_user

  let(:valid_attributes) do
    {
      address1: 'Test 1',
      address2: 'test 2',
      city: 'Test City',
      county: 'Test County',
      postcode: 'test',
      user_id: 1,
      site_name: 'Test Name',
      number_of_plots: 10,
      start_date: Date.today
    }
  end
  let(:valid_session) { {} }

  describe 'Get location index page' do
    it 'returns a success response' do
      Location.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'Get new location page' do
    it 'returns a success response' do
      @location = Location.create(valid_attributes)
      get :new, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'Get create location page' do
    it 'returns a found response' do
      @location = Location.new(valid_attributes)
      get :create, params: { location: valid_attributes }, session: valid_session
      # puts("Response status:" + response.status.to_s )
      expect(response).to have_http_status(302)
    end
  end

  describe 'Get a location page' do
    it 'returns a success response' do
      @location = Location.create(valid_attributes)
      get :show, params: { id: @location.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'Get a locations edit page' do
    it 'returns a success response' do
      @location = Location.create(valid_attributes)
      get :edit, params: { id: @location.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'Get a locations update page' do
    it 'returns a found response' do
      @location = Location.create(valid_attributes)
      get :update, params: { id: @location.id, location: valid_attributes }, session: valid_session
      # puts("Response methods:" + response.methods.to_s )
      # puts("Response status:" + response.status.to_s )
      expect(response).to have_http_status(302)
    end
  end
end
