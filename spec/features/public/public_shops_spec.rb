require 'rails_helper'

RSpec.feature "Public::Shops", type: :feature do

  let!(:coin1) { FactoryBot.create(:coin, name: "ビットコイン", rank: 1) }
  let!(:coin2) { FactoryBot.create(:coin, name: "リップル", rank: 2) }
  let!(:coin3) { FactoryBot.create(:coin, name: "イーサリアム", rank: 3) }

  let!(:shop1) { FactoryBot.create(:shop, name: "ビットフライヤー", address: "東京都渋谷区", company: "株式会社ビットフライヤー") }
  let!(:shop2) { FactoryBot.create(:shop, name: "コインチェック", address: "東京都港区0", company: "株式会社コインチェック") }
  let!(:shop3) { FactoryBot.create(:shop, name: "ザイフ", address: "東京都中央区", company: "株式会社ザイフ") }

  before do
    (4..40).each do |i|
      FactoryBot.create(:shop, name: "取引所名#{i}", address: "所在地#{i}", company: "会社名#{i}")
    end
    # shop1(ビットフライヤー)→ coin1(ビットコイン)、coin2(リップル)、coin3(イーサリアム)
    FactoryBot.create(:coin_shop, coin: coin1, shop: shop1)
    FactoryBot.create(:coin_shop, coin: coin2, shop: shop1)
    FactoryBot.create(:coin_shop, coin: coin3, shop: shop1)

    # shop2(コインチェック)→ coin1(ビットコイン)、coin2(リップル)
    FactoryBot.create(:coin_shop, coin: coin1, shop: shop1)
    FactoryBot.create(:coin_shop, coin: coin2, shop: shop1)

    # shop3(ザイフ)→ coin1(ビットコイン)
    FactoryBot.create(:coin_shop, coin: coin1, shop: shop1)


  end
  describe "取引所一覧" do
    it "取引所一覧が表示される(ページネーション)" do
      visit public_coins_path
      click_on "取引所"
      expect(page).to have_content coin1.name
      expect(page).to have_content "取引所名30"
      expect(page).not_to have_content "取引所名31"

      click_on "2"
      expect(page).not_to have_content "取引所名30"
      expect(page).to have_content "取引所名31"
    end
  end


  describe "詳細" do
    it "取引所詳細が表示される" do
      visit public_coins_path
      click_on "取引所"
      click_on "shop_#{shop1.id}"
      expect(page).to have_content "取引所詳細"
      expect(page).to have_content shop1.name
      expect(page).to have_content shop1.address
      expect(page).to have_content shop1.company
      shop1.coins.each do |coin|
        expect(page).to have_content coin.name
      end
    end
  end
end
