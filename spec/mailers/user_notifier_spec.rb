require 'rails_helper'

RSpec.describe UserNotifier, type: :mailer do
  describe '.token' do
    let(:user) { FactoryBot.build(:user) }

    it 'has a relevant subject' do
      mail = UserNotifier.token(user)
      expect(mail.subject).to include ': how to change your password'
    end

    it "sends to the user's email address" do
      mail = UserNotifier.token(user)
      expect(mail.to).to eq [user.email]
    end
  end
end
