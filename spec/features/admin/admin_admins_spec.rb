require 'rails_helper'

RSpec.feature "Admin::Admins", type: :feature do
  let(:admin) { FactoryBot.create(:admin) }
  before do
    sign_in admin
    (2..10).each do |i|
      FactoryBot.create(:admin, first_name: "first_name#{i}")
    end
  end
  describe "管理者一覧" do
    it "管理者一覧が表示される" do
      visit admin_coins_path
      click_on "管理者一覧"
      expect(page).to have_content "管理者一覧"
      expect(page).to have_content admin.first_name
    end
  end

  describe "管理者作成" do
    context "正常系" do
      it "管理者一覧を登録できる" do
        expect {
          visit admin_coins_path
          click_on "管理者一覧"
          click_on "新規作成"
          expect(page).to have_content "管理者作成"
          fill_in "admin[last_name]", with: "名前"
          fill_in "admin[first_name]", with: "苗字"
          fill_in "admin[email]", with: "test@test.com"
          fill_in "admin[password]", with: "testtest"
          fill_in "admin[password_confirmation]", with: "testtest"
          click_on "登録"
        }.to change(Admin, :count).by(1)
        expect(page).to have_content "管理者を登録しました"
      end
    end

    context "異常系(バリデーション)" do
      it "管理者一覧を登録できない" do
        expect {
          visit admin_coins_path
          click_on "管理者一覧"
          click_on "新規作成"
          expect(page).to have_content "管理者作成"
          fill_in "admin[last_name]", with: nil
          fill_in "admin[first_name]", with: "苗字"
          fill_in "admin[email]", with: "test@test.com"
          fill_in "admin[password]", with: "testtest"
          fill_in "admin[password_confirmation]", with: "testtest"
          click_on "登録"
        }.to change(Admin, :count).by(0)
        expect(page).to have_content ""
      end
    end
  end

  describe "管理者詳細" do
    it "管理者詳細が表示される" do
      visit admin_coins_path
      click_on "管理者一覧"
      find("#admin_#{admin.id}").click
      expect(page).to have_content "管理者詳細"
      expect(page).to have_content admin.first_name
    end
  end

  describe "管理者削除" do
    let!(:delete_admin) { FactoryBot.create(:admin) }
    it "管理者を削除できる" do
      visit admin_coins_path
      click_on "管理者一覧"
      find("#admin_#{delete_admin.id}").click
      expect(page).to have_content "管理者詳細"
      expect {
        click_on "削除"
      }.to change(Admin, :count).by(-1)
      expect(page).to have_content "管理者を削除しました"
    end
  end
end
