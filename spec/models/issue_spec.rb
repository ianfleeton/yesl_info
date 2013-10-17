require 'spec_helper'

describe Issue do
  describe '#start_time' do
    it 'returns date_due' do
      d = Date.today
      issue = Issue.new(date_due: d)
      expect(issue.start_time).to eq d
    end
  end
end
