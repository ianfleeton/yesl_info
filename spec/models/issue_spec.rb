require 'spec_helper'

describe Issue do
  describe '#to_s' do
    it 'returns its ID (issue number) and title' do
      issue = Issue.new(id: 123, title: 'Help!')
      expect(issue.to_s).to eq '#123: Help!'
    end
  end

  describe '#start_time' do
    it 'returns date_due' do
      d = Date.today
      issue = Issue.new(date_due: d)
      expect(issue.start_time).to eq d
    end
  end
end
