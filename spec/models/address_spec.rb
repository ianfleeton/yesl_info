require 'rails_helper'

describe Address do
  describe '#to_s' do
    it 'returns the first line and postcode' do
      a = Address.new(address_line_1: 'Street', postcode: 'POSTCODE')
      expect(a.to_s).to eq 'Street, POSTCODE'
    end
  end
end
