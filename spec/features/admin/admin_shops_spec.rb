require 'rails_helper'

RSpec.feature "Admin::Shops", type: :feature do
  let(:admin) { FactoryBot.create(:admin) }
  let!(:shop) { FactoryBot.create(:shop, name: "コインチェック") }
  before do
    sign_in admin
    (2..40).each do |i|
      FactoryBot.create(:shop, name: "取引所#{i}")
    end
  end

  describe "# index" do
    it "コイン一覧が表示される(ページネーション含む)" do
      visit admin_coins_path
      click_on "取引所一覧"
      expect(page).to have_content "取引所"
      expect(page).to have_content shop.name
      expect(page).to have_content "取引所30"
      expect(page).not_to have_content "取引所31"

      click_on "2"
      expect(page).not_to have_content "取引所30"
      expect(page).to have_content "取引所31"
    end
  end
end
