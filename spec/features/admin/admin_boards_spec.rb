require 'rails_helper'

RSpec.feature "Admin::Boards", type: :feature do
  # pending "add some scenarios (or delete) #{__FILE__}"
  #

  let(:admin) { FactoryBot.create(:admin) }
  feature "スレッド一覧" do
    let!(:board) { FactoryBot.create(:board, title: "rspecスレッド") }
    let!(:search_title_board1) { FactoryBot.create(:board, title: "search boards") }
    let!(:search_title_board2) { FactoryBot.create(:board, title: "search boards") }
    let!(:search_body_response1) { FactoryBot.create(:response, body: "search body", board: search_title_board1) }
    let!(:search_body_response2) { FactoryBot.create(:response, body: "search body", board: search_title_board2) }
    before do
      (4..40).each do |i|
        FactoryBot.create(:board, title: "create スレッド#{i}")
      end
    end
    context "認証済み" do
      before do
        sign_in admin
      end
      scenario "スレッド一覧が表示される(ページネーション含む)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        expect(page).to have_content "スレッド一覧"
        expect(page).to have_content board.title
        expect(page).to have_content "create スレッド30"
        expect(page).not_to have_content "create スレッド31"
        click_on "2"
        expect(page).not_to have_content "create スレッド30"
        expect(page).to have_content "create スレッド31"
      end

      scenario "検索されたスレッド一覧が表示される(title)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        fill_in "q", with: search_title_board1.title
        click_on "検索"
        expect(page).to have_content search_title_board1.title
      end

      scenario "検索されたスレッド一覧が表示される(title複数)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        fill_in "q", with: "#{search_title_board1.title} #{search_title_board2}"
        click_on "検索"
        expect(page).to have_content search_title_board1.title
        expect(page).to have_content search_title_board2.title
      end

      scenario "検索されたスレッド一覧が表示される(response.body)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        expect(page).to have_content "スレッド一覧"
        fill_in "q", with: search_body_response1.body
        click_on "検索"
        expect(page).to have_content search_body_response1.board.title
      end

      scenario "検索されたスレッド一覧が表示される(response.body複数)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        expect(page).to have_content "スレッド一覧"
        fill_in "q", with: "#{search_body_response1.body} #{search_body_response2.body}"
        click_on "検索"
        expect(page).to have_content search_body_response1.board.title
        expect(page).to have_content search_body_response2.board.title
      end

      scenario "検索されたスレッド一覧が表示される(title・response.body混在)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        expect(page).to have_content "スレッド一覧"
        fill_in "q", with: "#{search_title_board1.title} #{search_body_response2.body}"
        click_on "検索"
        expect(page).to have_content search_body_response1.board.title
        expect(page).to have_content search_body_response2.board.title
      end
    end
  end

  feature "スレッド削除" do
    context "認証済み" do
      let!(:board) { FactoryBot.create(:board, title: "rspecスレッド") }
      let!(:delete_board) { FactoryBot.create(:board, title: "削除用スレッド") }
      let!(:delete_response) { FactoryBot.create(:response, board: delete_board) }
      before do
        sign_in admin
      end
      it "スレッドを削除できる" do
        visit admin_coins_path
        click_on "スレッド一覧"
        expect(page).to have_content board.title
        expect(page).to have_content delete_board.title
        delete_before_responses_count = Response.count
        expect {
          click_on "board_#{delete_board.id}"
        }.to change(Board, :count).by(-1)
        expect(page).to have_content "スレッドを削除しました"
        expect(page).not_to have_content delete_board.title
        expect(page).to have_content board.title
        expect(Response.count).to eq (delete_before_responses_count - 1)
      end
    end
  end
end
