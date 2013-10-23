require 'spec_helper'

describe Organisation do
  describe '#to_s' do
    it 'returns its name' do
      expect(Organisation.new(name: 'YeSL').to_s).to eq 'YeSL'
    end
  end
end
