require 'rails_helper'

RSpec.feature "Public::Coins", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"

  let(:admin) { FactoryBot.create(:admin) }
  before do
    sign_in admin
  end

  let!(:coin1) { FactoryBot.create(:coin, name: "ビットコイン", rank: 1) }
  let!(:coin2) { FactoryBot.create(:coin, name: "リップル", rank: 2) }
  let!(:coin3) { FactoryBot.create(:coin, name: "イーサリアム", rank: 3) }
  describe "コイン一覧" do
    it "コイン一覧が表示される" do
      visit public_coins_path
      expect(page).to have_content "コイン一覧"
      expect(page).to have_content coin1.name
      expect(page).to have_content coin2.name
      expect(page).to have_content coin3.name
    end
  end
end
