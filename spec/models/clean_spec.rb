# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Clean, type: :model do
  before do
    @user = create(:user, id: 1, admin: true)
    @location = create(:location)
    @plot = @location.plots.first
    @house = create(:house)
    @extra = create(:extra)
    @plot_extra = PlotExtra.create({ plot: @plot, extra: @extra })
    @cost_house_location = create(:cost_house_location, location_id: @location.id, house_id: @house.id)
  end

  let(:valid_attributes) do
    {
      date: Date.parse('15/01/2021'),
      location: @location,
      plot: @plot,
      start_time: Time.parse('09:00'),
      end_time: Time.parse('12:00'),
      completed: true,
      clean_type: 'Pre-Paint',
      num_people: 1
    }
  end

  let(:clean) do
    Clean.create(valid_attributes)
  end

  describe 'a valid clean' do
    context 'with valid attributes' do
      it 'is valid' do
        expect(clean).to be_valid
      end
    end
  end

  describe 'an invalid clean' do
    context 'start time after end time' do
      before do
        clean.start_time = Time.parse('18:00')
      end
      it 'is not valid' do
        expect(clean).to_not be_valid
      end
    end

    context 'without start or end times' do
      before do
        clean.start_time = nil
        clean.end_time = nil
      end

      it 'is not valid' do
        expect(clean).to_not be_valid
      end
    end
  end

  # #Method testing

  describe 'extras_total' do
    it 'Calculates the total cost of any extras associated with the plot that the clean is associated with' do
      expect(clean.extras_total).to eq(10)
    end
  end

  describe 'hours_worked' do
    context 'start and end time supplied' do
      context 'valid times supplied' do
        it 'Calculates and returns the hours worked from start and end time of a clean' do
          expect(clean.hours_worked).to eq(3)
        end
      end
      context 'Start time after end time' do
        it 'raises exeption' do
          clean.start_time = Time.parse('13:00')
          expect { clean.hours_worked }.to raise_error(RuntimeError, 'Start time must be before end time')
        end
      end
    end
    context 'No start or end time supplied' do
      it 'raises exeption' do
        clean.start_time = nil
        clean.end_time = nil
        expect { clean.hours_worked }.to raise_error(RuntimeError, 'Start & end time must be specified')
      end
    end
  end

  describe 'clean_cost' do
    before do
      @plot.house_id = @house.id
      @plot.number = 1
    end
    context 'pre paint type' do
      before do
        clean.clean_type = 'Pre-Paint'
      end
      it 'returns correct value' do
        expect(clean.clean_cost).to eq(100)
      end
    end
    context 'post paint type' do
      before do
        clean.clean_type = 'Post-Paint'
      end
      it 'returns correct value' do
        expect(clean.clean_cost).to eq(90)
      end
    end
    context 'demo type' do
      before do
        clean.clean_type = 'Demo'
      end
      it 'returns correct value' do
        expect(clean.clean_cost).to eq(90)
      end
    end
    context 'sparkle type' do
      before do
        clean.clean_type = 'Sparkle'
      end
      it 'returns correct value' do
        expect(clean.clean_cost).to eq(80)
      end
    end
    context 'variation order type' do
      before do
        clean.clean_type = 'Variation Order'
      end
      it 'returns correct value' do
        expect(clean.clean_cost).to eq(60)
      end
    end
  end

  describe 'extras_total' do
    it 'returns the correct value for plot extras on the clean' do
      expect(clean.extras_total).to eq(10)
    end
  end

  describe 'stringify_address' do
    it 'returns a concatinated string of the locations address1 + address2 + city + postcode' do
      expect(clean.stringify_address).to eq(@location.address1 + ' ' + @location.address2 + ' ' + @location.city + ' ' + @location.postcode)
    end
  end
end
