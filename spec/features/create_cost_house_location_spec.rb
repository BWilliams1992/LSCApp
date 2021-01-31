require 'rails_helper'

  describe 'Creating a new link between a house and a sites price listing' do

    before do 
      @user1 = create(:user)
      @location = create(:location)
      @house = create(:house)
      login_as(@user1)
    end

    it 'can be created via new form' do
      visit new_location_cost_house_location_path(@location)

      fill_in 'cost_house_location_pre_paint_cost', with: 200
      fill_in 'cost_house_location_post_paint_cost', with: 190
      fill_in 'cost_house_location_sparkle_cost', with: 190
      fill_in 'cost_house_location_demo_cost', with: 180
      select 'House', from: 'cost_house_location_house_id'

      click_on 'commit'

      expect(@location.cost_house_locations.count).to eq(1)

    end

  end
