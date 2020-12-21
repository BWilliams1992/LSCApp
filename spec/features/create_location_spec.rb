require 'rails_helper'

describe 'navigate' do
  let(:user) do
    User.create(
      email: 'foo@bar.net',
      password: 'chicken',
      password_confirmation: 'chicken',
      admin: true
    )
  end

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

describe 'index' do
  it 'can be reached' do
    visit locations_path
    expect(page.status_code).to eq(200)
  end
end

describe 'creation' do
  before do 
    login_as(user)
    visit new_location_path
  end

  it 'has a new form that can be reached' do
    expect(page.status_code).to eq(200)
  end
  it 'can be created from a new form' do
    fill_in 'location_site_name' , with: 'Test name'
    fill_in 'location_address1' , with: 'Test address1'
    fill_in 'location_address2' , with: 'Test address2'
    fill_in 'location_number_of_plots' , with: '10'
    fill_in 'location_start_date' , with: Date.today.last_month()
    click_on 'commit'

    expect(page).to have_content('Test name')
  end
end
end