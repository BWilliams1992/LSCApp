require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:user) do
    User.create(
      email:"test@mail.com",
      password: "password",
      password_confirmation: "password"
    )
  end

  let(:valid_attributes){ 
    {:address1 => "Test1",
    :city => "test city",
    :postcode => "test postcode",
    :site_name => "Test name",
    :start_date => "01/01/2020",
    :user_id => user.id,
    :number_of_plots => 10}
  }

  let(:location) do
    Location.create(valid_attributes)
  end

  describe 'creation' do
    it 'can be created' do
      expect(location).to be_valid
      expect(Location.count).to eq(1)
      expect(Location.first.user_id).to eq(user.id)
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