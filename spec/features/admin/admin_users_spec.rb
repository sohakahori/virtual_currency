require 'rails_helper'

RSpec.feature "Admin::Users", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  #


  let(:admin) { FactoryBot.create(:admin) }
  let!(:user) { FactoryBot.create(:user, first_name: "first_name1") }
  before do
    sign_in admin
    (2..40).each do |i|
      FactoryBot.create(:user, first_name: "first_name#{i}")
    end
  end
  describe "ユーザー一覧", forcus: true do
    it "ユーザー一覧が表示される(ページネーション含む)" do
      visit admin_coins_path
      click_on "ユーザー一覧"
      expect(page).to have_content "ユーザー一覧"
      expect(page).to have_content user.first_name
      expect(page).not_to have_content "first_name31"
      click_on "2"
      expect(page).to have_content "first_name32"
      expect(page).not_to have_content user.first_name
    end
  end
end
