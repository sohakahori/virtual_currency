require 'rails_helper'

RSpec.feature "Public::UserResponses", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"

  let(:user) { FactoryBot.create(:user, nickname: "ニックネーム") }

  # Todo: created_at: descでソートしているがcreated_atが全て同時日時である
  feature '投稿コメント一覧' do
    let(:board1) { FactoryBot.create(:board, title: "スレッド1") }
    let(:board2) { FactoryBot.create(:board, title: "スレッド2") }
    before do
      (1..40).each do |i|
        if rand(1 .. 2) == 1
          FactoryBot.create(:response, body: "コメント#{i}", user: user, board: board1)
        else
          FactoryBot.create(:response, body: "コメント#{i}", user: user, board: board2)
        end
      end
    end
    let!(:response41) { FactoryBot.create(:response, body: "コメント41", user: user, board: board1) }
    let!(:search_response) { FactoryBot.create(:response, body: "検索用コメント", user: user) }
    context "認証済み" do
      before do
        sign_in user
      end
      it "コメント一覧が表示される(ページネーション含む)" do
        visit public_coins_path
        click_on "コメント投稿一覧"
        expect(page).to have_content "コメント投稿一覧"
        expect(page).to have_content "コメント15"
        click_on "2"
        expect(page).not_to have_content "コメント15"
      end

      it "検索されたコメント一覧が表示される(response.body)" do
        visit public_coins_path
        click_on "コメント投稿一覧"
        select search_response.board.title, from: "q"
        click_on "検索"
        expect(page).to have_content search_response.body
        expect(page).not_to have_content response41.body
      end
    end
  end

  feature "コメント削除" do
    context "認証済み" do
      before do
        sign_in user
      end
      let!(:delete_response) { FactoryBot.create(:response, user: user) }

      it "コメントを削除できる" do
        visit public_coins_path
        click_on "コメント投稿一覧"
        expect(page).to have_content delete_response.body
        expect {
          click_on "delete_response#{delete_response.id}"
        }.to change(Response, :count).by(-1)
        expect(page).to have_content "コメントを削除しました"
      end
    end
  end
end
