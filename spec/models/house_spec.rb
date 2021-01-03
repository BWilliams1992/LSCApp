require 'rails_helper'

RSpec.describe House, Type: :model do

  let(:valid_attributes){ 
    {:sales_name => "Cologne",
    :build_number => "00001111"}
  }

  let(:house) do
    House.create(valid_attributes)
  end

  describe 'creation' do
    it 'can be created' do
      expect(house).to be_valid
      expect(House.count).to eq(1)
    end
  end
  describe 'deletion' do
    it 'can be deleted' do
      house.destroy
      expect(House.count).to eq(0)
    end
  end

end