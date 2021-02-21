# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Clean, type: :model do
  before do
    @user = create(:user)
    @location = create(:location)
    @plot = @location.plots.first
    @extra = create(:extra)
    @plot_extra = PlotExtra.create({ plot: @plot, extra: @extra })
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
        clean.start_time = Time.parse("18:00")
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
          expect { clean.hours_worked }.to raise_error(RuntimeError,"Start time must be before end time")
        end
      end
    end
    context 'No start or end time supplied' do
      it 'raises exeption' do
        clean.start_time = nil
        clean.end_time = nil
        expect { clean.hours_worked }.to raise_error(RuntimeError,"Start & end time must be specified")
      end
    end
  end
end
