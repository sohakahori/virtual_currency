require 'rails_helper'

RSpec.feature "Public::Responses", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"

  let(:user) { FactoryBot.create(:user, nickname: "ニックネーム") }
  let!(:board) { FactoryBot.create(:board, title: "スレッド1") }
  describe "レスポンス一覧画面" do
    let!(:response) { FactoryBot.create(:response, body: "スレッド1 レスポンス1", board: board, user: user) }
    before do
      (2..40).each do |i|
        FactoryBot.create(:response, body: "レスポンス#{i}", board: board)
      end
    end
    context "認証済み" do
      before do
        sign_in user
      end
      it "レスポンス一覧画面が表示される(ページネーション含む)" do
        visit public_coins_path
        click_on "スレッド"
        click_on board.title
        expect(page).to have_content "コメント一覧"
        expect(page).to have_content  response.body
        expect(page).to have_content  user.nickname
        expect(page).to have_content  "レスポンス15"
        expect(page).not_to have_content  "レスポンス16"

        click_on "2"
        expect(page).not_to have_content  "レスポンス15"
        expect(page).to have_content  "レスポンス16"
      end
    end
  end

  describe "レスポンス(コメント)登録" do
    context "認証済み" do
      before do
        sign_in user
      end
      it "レスポンス(コメント)を登録できる" do
        visit public_coins_path
        click_on "スレッド"
        click_on board.title
        expect(page).to have_content "コメント一覧"
        expect(page).to have_content board.title
        click_on "コメントを書く", match: :first
        expect(page).to have_content "コメンント投稿"
        fill_in "コメント", with: "response commit"
        expect {
          click_on "登録する"
        }.to change(Response, :count).by(1)
        expect(page).to have_content "コメントを投稿しました"
      end
    end
  end

  describe "レスポンス(コメント)削除" do
    context "認証済み" do
      let!(:response) { FactoryBot.create(:response, board: board, user: user, body: "delete test comment") }
      before do
        sign_in user
        (2..10).each do |i|
          FactoryBot.create(:response, board: board)
        end
          end
      it "自ら投稿したコメントのみ削除できる" do
        visit public_coins_path
        click_on "スレッド"
        click_on board.title
        expect(page).to have_content("削除", count: 1)
        expect {
          click_on "削除"
        }.to change(Response, :count).by(-1)
        expect(page).to have_content "コメントを削除しました"
      end
    end
  end
end
