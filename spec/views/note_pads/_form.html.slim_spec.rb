require 'rails_helper'

RSpec.describe "note_pads/_form.html.slim", type: :view do
  it "renders a select tag for choosing an organisation" do
    assign(:note_pad, NotePad.new)
    render
    expect(rendered).to have_selector("select#note_pad_organisation_id")
  end
end