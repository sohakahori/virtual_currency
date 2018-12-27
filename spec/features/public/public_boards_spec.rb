require 'rails_helper'

RSpec.feature "Public::Boards", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  #

  let(:user) { FactoryBot.create(:user) }
  let!(:board1) { FactoryBot.create(:board, title: "テストスレッド#{1}") }
  before do
    (2..40).each do |i|
      FactoryBot.create(:board, title: "テストスレッド#{i}")
    end
  end

  describe "スレッド一覧", forcus: true do
    context "認証済み" do
      before do
        sign_in user
      end
      it "スレッド一覧が表示される(ページネーション)" do
        visit public_coins_path
        click_on "スレッド"
        expect(page).to have_content board1.title
        expect(page).to have_content "テストスレッド30"
        expect(page).not_to have_content "テストスレッド31"

        click_on "2"
        expect(page).not_to have_content "テストスレッド30"
        expect(page).to have_content "テストスレッド31"
      end
    end
  end

  describe "スレッド作成", forcus: true do
    context "認証済み・正常系" do
      before do
        sign_in user
      end
      it "スレッドを登録できる" do
        visit public_coins_path
        click_on "スレッド"
        click_on "スレッド作成"
        expect(page).to have_content "スレッド作成"
        before_response_count = Response.count
        expect {
          fill_in "board[title]", with: "新スレッド"
          fill_in "board[responses_attributes][0][body]", with: "コメント"
          click_on "登録する"
        }.to change(Board, :count).by(1)
        expect(Response.count).to eq (before_response_count + 1)
        expect(page).to have_content "スレッドを作成しました"
      end
    end

    context "認証済み・異常系" do
      before do
        sign_in user
      end
      it "バリデーションが適用される" do
        visit public_coins_path
        click_on "スレッド"
        click_on "スレッド作成"
        expect(page).to have_content "スレッド作成"
        before_response_count = Response.count
        expect {
          fill_in "board[title]", with: nil
          fill_in "board[responses_attributes][0][body]", with: nil
          click_on "登録する"
        }.to change(Board, :count).by(0)
        expect(Response.count).to eq before_response_count
        expect(page).to have_content "不正な入力値です"
      end
    end
  end
end
