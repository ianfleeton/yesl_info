require 'spec_helper'

describe 'issues/show' do
  let(:created_at) { Date.today - 1.week }
  let(:updated_at) { Date.today - 1.day }
  let(:date_due) { Date.today + 1.week }
  let(:issue) { FactoryGirl.create(:issue, created_at: created_at, updated_at: updated_at, date_due: date_due, estimated_time: 90) }
  before { assign(:issue, issue) }

  it 'shows the issue number' do
    render
    expect(rendered).to have_content "Issue ##{issue.id}"
  end

  it 'shows the issue title' do
    render
    expect(rendered).to have_content issue.title
  end

  it 'links to the organisation' do
    render
    expect(rendered).to have_content issue.organisation
    expect(rendered).to have_selector "a[href='#{organisation_path(issue.organisation)}']"
  end

  it 'links to the setter' do
    render
    expect(rendered).to have_content issue.setter
    expect(rendered).to have_selector "a[href='#{user_path(issue.setter)}']"
  end

  it 'shows when the issue was created' do
    render
    expect(rendered).to have_content issue.created_at
  end

  it 'shows the issue details' do
    render
    expect(rendered).to have_content issue.details
  end

  it 'shows the issue deadline' do
    render
    expect(rendered).to have_content issue.date_due
  end

  it 'shows the priority' do
    render
    expect(rendered).to have_content priority_name(issue.priority)
  end

  it 'links to the assignee' do
    render
    expect(rendered).to have_content issue.assignee
    expect(rendered).to have_selector "a[href='#{user_path(issue.assignee)}']"
  end

  it 'shows estimated time' do
    render
    expect(rendered).to have_content '90m'
  end

  context 'when estimated price is 0' do
    before { issue.estimated_price = 0 }

    it 'does not mention price' do
      render
      expect(rendered).not_to have_content t('issues.show.estimated_price')
    end
  end

  context 'when estimated price is 0' do
    before { issue.estimated_price = 75.00 }

    it 'displays estimated price' do
      render
      expect(rendered).to have_content t('issues.show.estimated_price')
      expect(rendered).to have_content '£75.00'
    end
  end

  it 'links to edit the issue' do
    render
    expect(rendered).to have_selector "a[href='#{edit_issue_path(issue)}']"
  end
end
