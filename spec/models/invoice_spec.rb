require 'rails_helper'

RSpec.describe Invoice, type: :model do

  before do
    @user = create(:user)
    @location = create(:location)
    @house = create(:house)
    @cost_house_location = CostHouseLocation.create( {
      pre_paint_cost: 100,
      post_paint_cost: 90,
      demo_cost: 90,
      sparkle_cost: 80,
      location: @location,
      house: @house
    } )
    @location.plots.each do |plot|
      plot.house_id = @house.id
      plot.save
    end
    @clean1 = create(:clean, location_id:@location.id, plot_id: @location.plots.first.id, completed: true, clean_type: "Pre-Paint" )
    @clean2 = create(:clean, location_id:@location.id, plot_id: @location.plots.second.id, completed: true, clean_type:"Sparkle" )
    @clean3 = create(:clean, location_id:@location.id, plot_id: @location.plots.third.id, clean_type:"Demo" )
    @clean4 = create(:clean, location_id:@location.id, plot_id: @location.plots.last.id, completed:true, clean_type:"Variation Order")
  end

  let(:valid_attributes){
    {start_date: Date.parse("01/01/2021"),
    end_date: Date.parse("31/01/2021"),
    location: @location}
  }

  let(:invoice) do
    Invoice.create(valid_attributes)
  end

  describe 'setting' do
    it 'can be set' do
      @invoice = Invoice.find(invoice.id)
      expect(@invoice).to be_valid
      expect(@invoice).to eq(invoice)
    end
  end

  describe 'creating' do
    it 'can be created' do
      expect(invoice).to be_valid
      expect(Invoice.count).to eq(2)
    end
  end

  describe 'updating' do 
    it 'can be updated' do
      invoice.update({ end_date: Date.parse("30/01/21") })
      expect(invoice.end_date).to eq(Date.parse("30/01/21"))
    end
  end

  describe 'deleting' do
    it 'can be deleted' do
      @invoice = Invoice.create(valid_attributes)
      @invoice.destroy
      expect(Invoice.count).to eq(1)
    end
  end

  describe 'total calculations' do

    it 'totals the cost of completed cleans associated with itself' do
      expect(invoice.completed_cost).to eq(240)
    end

    it 'totals the cost of pending cleans associated with itself' do 
      expect(invoice.pending_cost).to eq(90)
    end
    
    it 'totals the cost of all cleans associated with itself' do
      expect(invoice.total_cost).to eq(330)
    end

  end

  describe 'invoice_cleans' do
    it 'Returns an ActiveModel collection of cleans that are within the start and end dates of the invoice' do
      expect(invoice.invoice_cleans.count).to eq(4)
    end
  end

end