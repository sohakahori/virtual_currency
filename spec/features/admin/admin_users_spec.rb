require 'rails_helper'

RSpec.feature "Admin::Users", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  #


  let(:admin) { FactoryBot.create(:admin) }
  let!(:user) { FactoryBot.create(:user, first_name: "太郎", last_name: "山田", nickname: "ヤマタ", email: "user@user.com") }
  before do
    sign_in admin
    (2..40).each do |i|
      FactoryBot.create(:user, first_name: "first_name#{i}")
    end
  end
  describe "ユーザー一覧" do
    it "ユーザー一覧が表示される(ページネーション含む)" do
      visit admin_coins_path
      click_on "ユーザー一覧"
      expect(page).to have_content "ユーザー一覧"
      expect(page).to have_content user.first_name
      expect(page).not_to have_content "first_name31"
      click_on "2"
      save_and_open_page
      expect(page).to have_content "first_name32"
      expect(page).not_to have_content user.first_name
    end

    context "検索処理" do
      it "検索されたユーザー一覧が表示される(first_name)" do
        visit admin_coins_path
        click_on "ユーザー一覧"
        fill_in "q", with: user.first_name
        click_on "検索"
        expect(page).to have_content user.first_name
        expect(page).to have_content user.last_name
      end

      it "検索されたユーザー一覧が表示される(last_name)" do
        visit admin_coins_path
        click_on "ユーザー一覧"
        fill_in "q", with: user.last_name
        click_on "検索"
        expect(page).to have_content user.first_name
        expect(page).to have_content user.last_name
      end

      it "検索されたユーザー一覧が表示される(nickname)" do
        visit admin_coins_path
        click_on "ユーザー一覧"
        fill_in "q", with: user.nickname
        click_on "検索"
        expect(page).to have_content user.first_name
        expect(page).to have_content user.last_name
      end

      it "検索されたユーザー一覧が表示される(email)" do
        visit admin_coins_path
        click_on "ユーザー一覧"
        fill_in "q", with: user.email
        click_on "検索"
        expect(page).to have_content user.first_name
        expect(page).to have_content user.last_name
      end

      it "検索されたユーザー一覧が表示される(full_name)" do
        visit admin_coins_path
        click_on "ユーザー一覧"
        fill_in "q", with: "#{user.last_name} #{user.first_name}"
        click_on "検索"
        expect(page).to have_content user.first_name
        expect(page).to have_content user.last_name
      end
    end
  end

  describe "ユーザー削除" do
    context "正常系" do
      it "ユーザーを削除できる" do
        visit admin_coins_path
        click_on "ユーザー一覧"
        click_on "user_#{user.id}"
        expect(user.reload.deleted_at).not_to be nil
        expect(page).to have_content "ユーザーを削除しました"
      end
    end
  end
end
