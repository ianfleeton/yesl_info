require 'rails_helper'

RSpec.describe AddressesHelper, type: :helper do
  describe '#format_address_single_line' do
    context 'with fully supplied address' do
      let(:address) { Address.new(address_line_1: 'Street', address_line_2: 'Locality', town_city: 'Town', county: 'County', postcode: 'POST CODE') }

      it 'separates elements by commas' do
        expect(format_address_single_line(address)).to eq 'Street, Locality, Town, County, POST CODE'
      end
    end

    context 'with partially supplied address' do
      let(:address) { Address.new(address_line_1: 'Street', town_city: 'Town', postcode: 'POST CODE') }

      it 'collapses commas' do
        expect(format_address_single_line(address)).to eq 'Street, Town, POST CODE'
      end
    end
  end
end
