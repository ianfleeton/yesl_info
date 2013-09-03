require 'spec_helper'

describe ToDo do
  describe '#start_time' do
    it 'returns date_due' do
      d = Date.today
      to_do = ToDo.new(date_due: d)
      expect(to_do.start_time).to eq d
    end
  end
end
