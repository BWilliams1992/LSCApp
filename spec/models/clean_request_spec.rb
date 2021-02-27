require 'rails_helper'

RSpec.describe CleanRequest, type: :model do 
  before do 
    @user = create(:user)
    @location = create(:location)
    @clean_request = create(:clean_request, location: @location, date: Date.today + 2, user:@user )
  end

  describe 'A Clean Request' do
    context 'with valid attributes' do
      it 'is valid' do
         expect(@clean_request).to be_valid
      end
    end
    
    context 'with invalid attributes' do
      context 'date is not at least a day in advance' do
        before do 
          @clean_request.date = Date.today
        end
        it 'is not valid' do 
           expect(@clean_request).to_not be_valid
        end
      end
    end
  end

  describe 'Methods' do
    context 'convert_to_clean' do
      it 'creates a new clean based on the clean request' do
        @clean_request.convert_to_clean
        expect(Clean.count).to eq(1)
        expect(Clean.first.date).to eq(@clean_request.date)
        expect(Clean.first.location).to eq(@clean_request.location)
        expect(Clean.first.plot_id).to eq(@clean_request.location.plots.find_by(number: @clean_request.plot_number).id)
        expect(Clean.first.clean_type).to eq(@clean_request.clean_type)
        expect(Clean.first.completed).to eq(false)
      end
    end

    context 'approved_check' do
      context 'approved attribute has not changed' do
        it 'returns false' do
          expect(@clean_request.approved_check).to eq(false)
        end
      end
      context 'approved attribute has changed' do
        before do 
          @clean_request.approved = true
        end
        context 'is true' do
          it 'delivers an email notification' do
            @clean_request.approved_check
            expect(ActionMailer::Base.deliveries.count).to eq(1)
          end
        end
        context 'is false' do 
          before do 
            @clean_request.approved = false
          end
          it 'does not deliver an email notification' do
            @clean_request.approved_check
            expect(ActionMailer::Base.deliveries.count).to eq(0)
          end
        end
      end
    end

    context 'date_24_hours_in_advance' do 
      context 'date is at least a day in advance' do
        it 'returns nil' do
          expect(@clean_request.date_24_hours_in_advance).to eq(nil)
        end
      end
      context 'date is same day' do
        before do 
          @clean_request.date = Date.today()
        end
        it 'returns an error' do
          expect(@clean_request.date_24_hours_in_advance).to eq(["Date must be at least a day in advance"])
        end
      end
    end
  end
end