require 'spec_helper'

describe User do
  describe '#to_s' do
    it 'returns its name' do
      expect(User.new(name: 'Bob').to_s).to eq 'Bob'
    end
  end
end
