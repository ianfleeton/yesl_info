require 'rails_helper'

RSpec.describe Domain, type: :model do
  describe '#to_s' do
    it 'returns its name' do
      expect(Domain.new(name: 'example.org').to_s).to eq 'example.org'
    end
  end
end
