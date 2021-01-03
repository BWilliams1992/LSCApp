require 'rails_helper'

RSpec.describe LocationsController, type: :controller do

  login_user

  let(:valid_attributes) {
    {
      address1: "Test 1", 
      address2: "test 2", 
      city: "Test City",
      county: "Test County",
      postcode: "test",
      user_id: 1,
      site_name:"Test Name",
      number_of_plots: 10,
      start_date: Date.today
    }
  }
  let(:valid_session) { {} }

  describe "Get #index" do
    it "returns a success response" do
      Location.create! valid_attributes
      get :index, params: {}, session: valid_session 
       expect(response).to be_successful
    end
  end
end