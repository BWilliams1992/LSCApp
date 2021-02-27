# frozen_string_literal: true

require 'rails_helper'

describe 'Viewing pages as different users' do
  before do
    @user = create(:user, id: 1)
    @staff = create(:user, id: 2, staff: true, email:"staff@email.com")
    @admin = create(:user, id: 3, admin: true, email: "admin@email.com")
    @location = create(:location)
    @house = create(:house)
    @plot = @location.plots.first
    @plot.update({ house_id: @house.id })
    @clean1 = create(:clean, location_id: @location.id, date: Date.today, plot_id: @plot.id, completed: true,
                             clean_type: 'Pre-Paint')
    @clean2 = create(:clean, location_id: @location.id, date: Date.today, plot_id: @plot.id, completed: true,
                             clean_type: 'Variation Order')
    @clean3 = create(:clean, location_id: @location.id, date: Date.today, plot_id: @plot.id, clean_type: 'Demo')
    @cost_house_location = CostHouseLocation.create({ house_id: @house.id, location_id: @location.id,
                                                      pre_paint_cost: 100, post_paint_cost: 90, demo_cost: 90, sparkle_cost: 80 })
    @extra = create(:extra)
    @plot_extra = PlotExtra.create({ plot: @location.plots.first, extra: @extra })
    @invoice = @location.invoices.first
  end

  describe 'Viewing the site as a user' do
    before do
      login_as(@user)
      visit root_path
    end
    context 'Visiting the clean requests index page' do
      before do 
        visit clean_requests_path
      end
      it 'can be viewed' do
        expect(page.status_code).to eq(200)
      end
      context 'Navbar content' do 
        it 'does not have links for resources user is not allowed to access' do
          expect(page).to have_link("Clean Requests", :href=>"/clean_requests")
          expect(page).to_not have_link("Cleans", :href=>"/cleans")
          expect(page).to_not have_link("Locations", :href=>"/locations")
          expect(page).to_not have_link("Houses", :href=>"/houses")
          expect(page).to_not have_link("Extras", :href=>"/extras")
          expect(page).to_not have_link("Invoices", :href=>"/invoices")
          expect(page).to_not have_link("Users", :href=>"/users")
        end
      end
    end
    context 'Visiting the clean index page' do
      it 'cannot be viewed' do
        expect{page.visit cleans_path }.to  raise_error(CanCan::AccessDenied)
      end
    end
    context 'Visiting the locations index page' do
      it 'cannot be viewed' do
        expect{page.visit locations_path }.to  raise_error(CanCan::AccessDenied)
      end
    end
    context 'Visiting the houses index page' do
      it 'cannot be viewed' do
        expect{page.visit houses_path }.to  raise_error(CanCan::AccessDenied)
      end
    end
    context 'Visiting the extras index page' do
      it 'cannot be viewed' do
        expect{page.visit extras_path }.to  raise_error(CanCan::AccessDenied)
      end
    end
    context 'Visiting the invoices index page' do
      it 'cannot be viewed' do
        expect{page.visit invoices_path }.to  raise_error(CanCan::AccessDenied)
      end
    end
    context 'Visiting the users index page' do
      it 'cannot be viewed' do
        expect{page.visit users_path }.to  raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'Viewing the site as staff' do
    before do
      login_as(@staff)
      visit root_path
    end
    context 'Visiting the clean requests index page' do
      before do 
        visit clean_requests_path
      end
      it 'can be viewed' do
        expect(page.status_code).to eq(200)
      end
      context 'Navbar content' do 
        it 'does not have links for resources user is not allowed to access' do
          expect(page).to have_link("Clean Requests", :href=>"/clean_requests")
          expect(page).to have_link("Cleans", :href=>"/cleans")
          expect(page).to have_link("Locations", :href=>"/locations")
          expect(page).to have_link("Houses", :href=>"/houses")
          expect(page).to have_link("Extras", :href=>"/extras")
          expect(page).to have_link("Invoices", :href=>"/invoices")
          expect(page).to_not have_link("Users", :href=>"/users")
        end
      end
    end
    context 'Visiting the clean index page' do
      it 'can be viewed' do
        expect(page.status_code).to eq(200)
      end
    end
    context 'Visiting the locations index page' do
      it 'can be viewed' do
        expect(page.status_code).to eq(200)
      end
    end
    context 'Visiting the houses index page' do
      it 'can be viewed' do
        expect(page.status_code).to eq(200)
      end
    end
    context 'Visiting the extras index page' do
      it 'can be viewed' do
        expect(page.status_code).to eq(200)
      end
    end
    context 'Visiting the invoices index page' do
      it 'can be viewed' do
        expect(page.status_code).to eq(200)
      end
    end
    context 'Visiting the users index page' do
      it 'cannot be viewed' do
        expect{page.visit users_path }.to  raise_error(CanCan::AccessDenied)
      end
    end
  end

  describe 'Viewing the site as admin' do
    before do
      login_as(@admin)
      visit root_path
    end
    context 'Visiting the clean requests index page' do
      before do 
        visit clean_requests_path
      end
      it 'can be viewed' do
        expect(page.status_code).to eq(200)
      end
      context 'Navbar content' do 
        it 'does not have links for resources user is not allowed to access' do
          expect(page).to have_link("Clean Requests", :href=>"/clean_requests")
          expect(page).to have_link("Cleans", :href=>"/cleans")
          expect(page).to have_link("Locations", :href=>"/locations")
          expect(page).to have_link("Houses", :href=>"/houses")
          expect(page).to have_link("Extras", :href=>"/extras")
          expect(page).to have_link("Invoices", :href=>"/invoices")
          expect(page).to have_link("Users", :href=>"/users")
        end
      end
    end
    context 'Visiting the clean index page' do
      it 'can be viewed' do
        expect(page.status_code).to eq(200)
      end
    end
    context 'Visiting the locations index page' do
      it 'can be viewed' do
        expect(page.status_code).to eq(200)
      end
    end
    context 'Visiting the houses index page' do
      it 'can be viewed' do
        expect(page.status_code).to eq(200)
      end
    end
    context 'Visiting the extras index page' do
      it 'can be viewed' do
        expect(page.status_code).to eq(200)
      end
    end
    context 'Visiting the invoices index page' do
      it 'can be viewed' do
        expect(page.status_code).to eq(200)
      end
    end
    context 'Visiting the users index page' do
      it 'can be viewed' do
        expect(page.status_code).to eq(200)
      end
    end
  end
end
