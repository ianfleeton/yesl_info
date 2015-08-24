require 'rails_helper'

RSpec.describe TimesheetEntry, type: :model do
  describe "before_validation :set_non_nil_values" do
    it "sets non-nil values" do
      timesheet = TimesheetEntry.new(invoice_value: nil, minutes: nil)
      timesheet.valid?
      expect(timesheet.invoice_value).to eq 0
      expect(timesheet.minutes).to eq 0
    end
  end
end
