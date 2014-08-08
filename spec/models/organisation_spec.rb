require 'rails_helper'

describe Organisation do
  describe '#to_s' do
    it 'returns its name' do
      expect(Organisation.new(name: 'YeSL').to_s).to eq 'YeSL'
    end
  end

  describe '#open_issue_estimated_price_total' do
    it 'returns the sum of estimated prices for open issues' do
      o = FactoryGirl.create(:organisation)
      o.issues << FactoryGirl.build(:issue, estimated_price: 33.00, completed: false)
      o.issues << FactoryGirl.build(:issue, estimated_price: 66.00, completed: false)
      o.issues << FactoryGirl.build(:issue, estimated_price: 20.00, completed: true)
      expect(o.open_issue_estimated_price_total).to eq 99.0
    end
  end
end
