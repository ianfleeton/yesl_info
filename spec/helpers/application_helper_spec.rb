require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#tick_cross(val)' do
    subject { tick_cross(val) }
    context 'val is true' do
      let(:val) { true }
      it { should eq a_tick }
    end
    context 'val is false' do
      let(:val) { false }
      it { should eq a_cross }
    end
  end

  describe '#tick(val)' do
    subject { tick(val) }
    context 'val is true' do
      let(:val) { true }
      it { should eq a_tick }
    end
    context 'val is false' do
      let(:val) { false }
      it { should be_nil }
    end
  end
end
