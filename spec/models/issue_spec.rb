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

    it "returns today's date if date_due is nil" do
      issue = Issue.new(date_due: nil)
      expect(issue.start_time).to eq Date.today
    end
  end

  describe '#watchers' do
    it 'includes the assignee' do
      issue = FactoryGirl.build(:issue)
      expect(issue.watchers).to include issue.assignee
    end

    it 'includes the setter' do
      issue = FactoryGirl.build(:issue)
      expect(issue.watchers).to include issue.setter
    end

    it "includes the organisation's watchers" do
      organisation = FactoryGirl.create(:organisation)
      watcher = FactoryGirl.create(:user)
      OrganisationWatcher.create!(organisation: organisation, watcher: watcher)
      issue = FactoryGirl.build(:issue, organisation: organisation)
      expect(issue.watchers).to include watcher
    end

    it 'removes duplicates' do
      assignee_setter = FactoryGirl.create(:user)
      issue = FactoryGirl.build(:issue, assignee: assignee_setter, setter: assignee_setter)
      expect(issue.watchers.count(assignee_setter)).to eq 1
    end
  end
end
