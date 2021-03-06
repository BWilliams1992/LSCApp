# frozen_string_literal: true

require 'rails_helper'

describe 'Create a new location via new location form' do
  before do
    user = create(:user)
    login_as(user)
  end

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

  describe 'Visit location index page' do
    it 'can be reached' do
      visit locations_path
      expect(page.status_code).to eq(200)
    end
  end

  describe 'Visit new location page' do
    before do
      visit new_location_path
    end

    it 'has a new form that can be reached' do
      expect(page.status_code).to eq(200)
    end
    it 'can be created from a new form' do
      fill_in 'location_site_name', with: 'Test name'
      fill_in 'location_address1', with: 'Test address1'
      fill_in 'location_address2', with: 'Test address2'
      fill_in 'location_city', with: 'Test City'
      fill_in 'location_postcode', with: 'Test Postcode'
      fill_in 'location_number_of_plots', with: '10'
      fill_in 'location_start_date', with: Date.today.last_month
      click_on 'commit'

      expect(page).to have_content('Test name')
      # testing to see that it creates plots after it has been created.
      expect(Location.last.plots.count).to eq(10)
    end
  end
end
