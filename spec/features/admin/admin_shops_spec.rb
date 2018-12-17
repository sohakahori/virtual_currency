require 'rails_helper'

RSpec.feature "Admin::Shops", type: :feature do
  let!(:coin1) { FactoryBot.create(:coin, name: "ビットコイン") }
  let(:admin) { FactoryBot.create(:admin) }
  let!(:shop) { FactoryBot.create(:shop, name: "コインチェック") }
  before do
    sign_in admin

    FactoryBot.create(:coin_shop, coin: coin1, shop: shop)
    (2..40).each do |i|
      FactoryBot.create(:shop, name: "取引所#{i}")
    end
  end

  describe "# 一覧ページ" do
    it "取引所一覧が表示される(ページネーション含む)" do
      visit admin_coins_path
      click_on "取引所一覧"
      expect(page).to have_content "取引所"
      expect(page).to have_content shop.name
      shop.coins.each do |coin|
        expect(page).to have_content coin.name
      end
      expect(page).to have_content "取引所30"
      expect(page).not_to have_content "取引所31"

      click_on "2"
      expect(page).not_to have_content "取引所30"
      expect(page).to have_content "取引所31"
    end
  end

  describe "# 詳細ページ" do
    it "取引所詳細が表示される" do
      visit admin_coins_path
      click_on "取引所一覧"
      find("#shop_#{shop.id}").click
      expect(page).to have_content "取引所詳細"
      expect(page).to have_content shop.name
      expect(page).to have_content shop.address
      shop.coins.each do |coin|
        expect(page).to have_content coin.name
      end
    end
  end

  describe "# 作成処理" do
    context "正常系" do
      it "取引所を作成できる" do
        visit admin_coins_path
        click_on "取引所一覧"
        click_on "新規作成"
        expect(page).to have_content "取引所作成"

        old_coin_shops_count = CoinShop.count
        expect {
          fill_in "shop[name]", with: "バイナンス"
          fill_in "shop[address]", with: "東京都港区"
          fill_in "shop[company]", with: "株式会社バイナンス"
          check "#{coin1.name}"
          click_on "登録する"
        }.to change(Shop, :count).by(1)

        # 中間テーブルにレコードが作成されていること
        expect(old_coin_shops_count).to eq CoinShop.count - 1
      end
    end

    context "異常系(バリデーション適用時)" do
      it "取引所を作成できない" do
        visit admin_coins_path
        click_on "取引所一覧"
        click_on "新規作成"
        expect(page).to have_content "取引所作成"

        expect {
          fill_in "shop[name]", with: nil
          fill_in "shop[address]", with: "東京都港区"
          fill_in "shop[company]", with: "株式会社バイナンス"
          check "#{coin1.name}"
          click_on "登録する"
        }.to change(Shop, :count).by(0)
        expect(page).to have_content "不正な入力値です"
      end
    end
  end

  describe "# 更新処理" do
    let!(:coin2) { FactoryBot.create(:coin, name: "リップル") }

    context "正常系" do
      it "取引所が更新できる" do
        visit admin_coins_path
        click_on "取引所一覧"
        find("#shop_#{shop.id}").click
        expect(page).to have_content "取引所詳細"
        click_on "編集"
        old_coin_shop_ids = shop.coin_shops.ids
        fill_in "取引所名", with: "取引所名更新"
        fill_in "住所", with: "住所更新"
        fill_in "会社名", with: "会社名更新"
        uncheck('ビットコイン')
        check('リップル')
        click_on "更新"
        expect(page).to have_content "取引所名更新"
        expect(page).to have_content "会社名更新"
        expect(page).to have_content "住所更新"
        expect(page).not_to have_content "ビットコイン"
        expect(page).to have_content "リップル"
        expect(old_coin_shop_ids).not_to eq shop.coin_shops.ids
      end
    end

    context "異常系(バリデーション)" do
      it "取引所を更新できない" do
        visit admin_coins_path
        click_on "取引所一覧"
        find("#shop_#{shop.id}").click
        expect(page).to have_content "取引所詳細"
        click_on "編集"
        fill_in "取引所名", with: nil
        fill_in "住所", with: "住所更新"
        fill_in "会社名", with: "会社名更新"
        uncheck('ビットコイン')
        check('リップル')
        click_on "更新"

        expect(shop.reload.address).not_to eq "住所更新"
        expect(page).to have_content "不正な入力値です"
      end
    end
  end
end
