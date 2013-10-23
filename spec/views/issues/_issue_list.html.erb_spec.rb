require 'spec_helper'

describe 'issues/_issue_list' do
  let(:issue) { FactoryGirl.create(:issue, created_at: Date.today - 1.week, updated_at: Date.today - 1.day) }
  
  it 'displays the issue' do
    render_issues
    expect(rendered).to have_content(issue)
  end

  it 'links to the issue' do
    render_issues
    expect(rendered).to have_selector("a[href='#{issue_path(issue)}']")
  end

  it 'shows the date created' do
    render_issues
    expect(rendered).to have_content(issue.created_at.to_date)
  end

  it 'shows the date updated' do
    render_issues
    expect(rendered).to have_content(issue.updated_at.to_date)
  end

  def render_issues
    render partial: 'issues/issue_list', locals: { issues: [issue] }
  end
end
