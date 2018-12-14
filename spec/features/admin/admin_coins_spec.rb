require 'rails_helper'

RSpec.feature "Admin::Coins", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"

  let(:admin) { FactoryBot.create(:admin) }
  before do
    sign_in admin
  end

  let!(:coin1) { FactoryBot.create(:coin, name: "ビットコイン", market_rank: 1) }
  let!(:coin2) { FactoryBot.create(:coin, name: "リップル", market_rank: 2) }
  let!(:coin3) { FactoryBot.create(:coin, name: "イーサリアム", market_rank: 3) }

  describe "# index" do
    it "コイン一覧が表示されること" do
      visit admin_coins_path
      expect(page).to have_content coin1.name
      expect(page).to have_content coin2.name
      expect(page).to have_content coin3.name
    end
  end
end
