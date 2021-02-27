# frozen_string_literal: true

require 'rails_helper'

describe 'Viewing an invoice show page' do
  before do
    @user = create(:user, id: 1, admin:true)
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

  describe 'Viewing the page' do
    before do
      login_as(@user)
      visit invoice_path(@invoice)
    end

    it 'Displays the correct start date on the page' do
      expect(page).to have_content(@invoice.start_date.strftime('%d/%^b/%Y'))
    end

    it 'Displays the correct end date on the page' do
      expect(page).to have_content(@invoice.end_date.strftime('%d/%^b/%Y'))
    end

    it 'Displays the correct location title on the page' do
      expect(page).to have_content(@location.site_name)
    end

    it 'Displays the correct costs for cleans' do
      expect(page).to have_content(@cost_house_location.pre_paint_cost)
      expect(page).to have_content('£60')
    end

    it 'Displays the correct costs for Extras' do
      expect(page).to have_content(@extra.cost)
    end

    it 'Displays the correct costs for the invoice' do
      expect(page).to have_content(@invoice.completed_cost)
    end

    it 'Displays the correct number of cleans' do
      expect(page).to have_content('Number of cleans: 3')
    end
  end
end
