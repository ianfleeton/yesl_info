shared_examples 'a show organisation page' do
  it "shows a total of the organisation's open issue estimated prices" do
    org = FactoryGirl.create(:organisation)
    org.stub(:open_issue_estimated_price_total).and_return(99.0)
    assign(:organisation, org)
    render
    expect(rendered).to have_content '£99.00'
  end
end
