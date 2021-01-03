require 'rails_helper'

RSpec.describe Invoice, type: :model do

  before do
    @user = create(:user)
    @location = create(:location)
    @house = create(:house)
    @cost_house_location = CostHouseLocation.create( {
      build_cost: 100,
      demo_cost: 90,
      sparkle_cost: 80,
      location: @location,
      house: @house
    } )
    @location.plots.each do |plot|
      plot.house_id = @house.id
      plot.save
    end
    @clean1 = create(:clean, location_id:@location.id, plot_id: @location.plots.first.id, invoice_id: invoice.id, completed: true )
    @clean2 = create(:clean, location_id:@location.id, plot_id: @location.plots.second.id, invoice_id: invoice.id, completed: true, clean_type:"Sparkle" )
    @clean2 = create(:clean, location_id:@location.id, plot_id: @location.plots.third.id, invoice_id: invoice.id )
  end

  let(:valid_attributes){
    {start_date: Date.parse("01/01/2021"),
    end_date: Date.parse("31/01/2021"),
    location: @location}
  }

  let(:invoice) do
    Invoice.create(valid_attributes)
  end

  describe 'creation' do
    it 'can be created' do
      expect(invoice).to be_valid
      expect(Invoice.count).to eq(2)
    end
  end

  describe 'total calculation' do

    it 'totals the cost of completed cleans associated with itself' do
      expect(invoice.completed_cost).to eq(180)
    end

    it 'totals the cost of pending cleans associated with itself' do 
      expect(invoice.pending_cost).to eq(100)
    end
    
    it 'totals the cost of all cleans associated with itself' do
      expect(invoice.total_cost).to eq(280)
    end

  end

end