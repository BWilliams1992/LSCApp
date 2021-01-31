require 'rails_helper'

RSpec.describe Location, type: :model do

  before do 
    @user = create(:user)
  end

  let(:valid_attributes){ 
    {:address1 => "Test1",
      :city => "test city",
      :postcode => "test postcode",
      :site_name => "Test name",
      :start_date => "01/01/2020",
      :user_id => @user.id,
      :number_of_plots => 10,
      :vo_cost => 20}
  }

  let(:location) do
    Location.create(valid_attributes)
  end

  describe 'creation' do
    it 'can be created' do
      expect(location).to be_valid
      expect(Location.count).to eq(1)
      expect(Location.first.user_id).to eq(@user.id)
    end
    describe 'after creation' do
      it 'creates plots' do
        expect(location.plots.count).to eq(location.number_of_plots)
      end
      it 'creates invoices' do 
        expect(location.invoices.count).to eq((Date.today.month - location.start_date.month) + 1 )
      end
    end
  end

  context 'with invalid attributes' do
    let (:valid_attributes) { nil }

    it 'is not created' do
      expect(location).to_not be_valid
      expect(Location.count).to eq(0)
    end
  end
  describe 'deletion' do 
    it 'can be deleted' do
      location.destroy
      expect(Location.count).to eq(0)
    end
  end
end