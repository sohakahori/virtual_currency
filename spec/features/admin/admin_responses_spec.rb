require 'rails_helper'

RSpec.feature "Admin::Responses", type: :feature do
  let(:admin) { FactoryBot.create(:admin) }
  feature 'コメント一覧' do
    context "認証済み" do
      let(:board) { FactoryBot.create(:board) }
      let(:user) { FactoryBot.create(:user) }
      let!(:response) { FactoryBot.create(:response, board: board) }
      let!(:search_response1) { FactoryBot.create(:response, board: board) }
      let!(:search_response2) { FactoryBot.create(:response, board: board) }
      let!(:search_user_response1) { FactoryBot.create(:response, board: board, user: user) }
      let!(:search_user_response2) { FactoryBot.create(:response, board: board, user: user) }
      before do
        sign_in admin
        (6..40).each do |i|
          FactoryBot.create(:response, body: "rspec comment#{i}", board: board)
        end
      end
      scenario "コメント一覧が表示されている(ページネーション含む)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        expect(page).to have_content board.title
        click_on "board_responses_#{board.id}"
        expect(page).to have_content "コメント一覧"
        expect(page).to have_content response.body
        expect(page).to have_content "rspec comment30"
        expect(page).not_to have_content "rspec comment31"
        click_on "2"
        expect(page).not_to have_content "rspec comment30"
        expect(page).to have_content "rspec comment31"
      end

      scenario "検索されたコメント一覧が表示されている(ID)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        expect(page).to have_content board.title
        click_on "board_responses_#{board.id}"
        expect(page).to have_content "コメント一覧"
        expect(page).to have_content response.body
        fill_in "q[response]", with: search_response1.id
        click_on "検索"
        expect(page).to have_content search_response1.body
        expect(page).not_to have_content response.body
      end

      scenario "検索されたコメント一覧が表示されている(ID複数)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        expect(page).to have_content board.title
        click_on "board_responses_#{board.id}"
        expect(page).to have_content "コメント一覧"
        expect(page).to have_content response.body
        fill_in "q[response]", with: "#{search_response1.id} #{search_response2.id}"
        click_on "検索"
        expect(page).to have_content search_response1.body
        expect(page).to have_content search_response2.body
        expect(page).not_to have_content response.body
      end

      scenario "検索されたコメント一覧が表示されている(body)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        expect(page).to have_content board.title
        click_on "board_responses_#{board.id}"
        expect(page).to have_content "コメント一覧"
        expect(page).to have_content response.body
        fill_in "q[response]", with: search_response1.body
        puts search_response1.body.inspect
        click_on "検索"
        save_and_open_page
        expect(page).to have_content search_response1.body
        expect(page).not_to have_content response.body

      end

      scenario "検索されたコメント一覧が表示されている(body複数)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        expect(page).to have_content board.title
        click_on "board_responses_#{board.id}"
        expect(page).to have_content "コメント一覧"
        expect(page).to have_content response.body
        fill_in "q[response]", with: "#{search_response1.body} #{search_response2.body}"
        click_on "検索"
        expect(page).to have_content search_response1.body
        expect(page).to have_content search_response2.body
        expect(page).not_to have_content response.body
      end

      scenario "検索されたコメント一覧が表示されている(id・body)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        expect(page).to have_content board.title
        click_on "board_responses_#{board.id}"
        expect(page).to have_content "コメント一覧"
        expect(page).to have_content response.body
        fill_in "q[response]", with: "#{search_response1.id} #{search_response2.body}"
        click_on "検索"
        expect(page).to have_content search_response1.body
        expect(page).to have_content search_response2.body
        expect(page).not_to have_content response.body
      end

      scenario "検索されたコメント一覧が表示されている(user.id)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        expect(page).to have_content board.title
        click_on "board_responses_#{board.id}"
        expect(page).to have_content "コメント一覧"
        expect(page).to have_content response.body
        fill_in "q[user]", with: search_user_response1.user.id
        click_on "検索"
        expect(page).to have_content search_user_response1.body
        expect(page).not_to have_content response.body
      end

      scenario "検索されたコメント一覧が表示されている(user.id複数)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        expect(page).to have_content board.title
        click_on "board_responses_#{board.id}"
        expect(page).to have_content "コメント一覧"
        expect(page).to have_content response.body
        fill_in "q[user]", with: "#{search_user_response1.user.id} #{search_user_response2.user.id}"
        click_on "検索"
        expect(page).to have_content search_user_response1.body
        expect(page).to have_content search_user_response2.body
        expect(page).not_to have_content response.body
      end

      scenario "検索されたコメント一覧が表示されている(user.full_name)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        expect(page).to have_content board.title
        click_on "board_responses_#{board.id}"
        expect(page).to have_content "コメント一覧"
        expect(page).to have_content response.body
        fill_in "q[user]", with: "#{search_user_response1.user.last_name}#{search_user_response1.user.first_name}"
        click_on "検索"
        expect(page).to have_content search_user_response1.body
        expect(page).not_to have_content response.body
      end

      scenario "検索されたコメント一覧が表示されている(user.full_name複数)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        expect(page).to have_content board.title
        click_on "board_responses_#{board.id}"
        expect(page).to have_content "コメント一覧"
        expect(page).to have_content response.body
        fill_in "q[user]",
                with: "#{search_user_response1.user.last_name}#{search_user_response1.user.first_name} #{search_user_response2.user.last_name}#{search_user_response2.user.first_name}"
        click_on "検索"
        expect(page).to have_content search_user_response1.body
        expect(page).to have_content search_user_response2.body
        expect(page).not_to have_content response.body
      end

      scenario "検索されたコメント一覧が表示されている(user.id・user.full_name)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        expect(page).to have_content board.title
        click_on "board_responses_#{board.id}"
        expect(page).to have_content "コメント一覧"
        expect(page).to have_content response.body
        fill_in "q[user]", with: "#{search_user_response1.user.id} #{search_user_response2.user.last_name}#{search_user_response2.user.first_name}"
        click_on "検索"
        expect(page).to have_content search_user_response1.body
        expect(page).to have_content search_user_response2.body
        expect(page).not_to have_content response.body
      end

      scenario "検索されたコメント一覧が表示されているAND条件(id AND user.id)" do
        visit admin_coins_path
        click_on "スレッド一覧"
        expect(page).to have_content board.title
        click_on "board_responses_#{board.id}"
        expect(page).to have_content "コメント一覧"
        expect(page).to have_content response.body
        fill_in "q[response]", with: search_response1.id
        fill_in "q[user]", with: search_response1.user.id
        click_on "検索"
        expect(page).to have_content search_response1.body
        expect(page).not_to have_content response.body

        fill_in "q[response]", with: search_response1.id
        fill_in "q[user]", with: search_user_response1.user.id
        click_on "検索"
        expect(page).not_to have_content search_response1.body
        expect(page).not_to have_content search_user_response1.body
        expect(page).not_to have_content response.body
      end
    end

    feature "コメント詳細" do
      context "認証済み" do
        before do
          sign_in admin
        end
        let(:board) { FactoryBot.create(:board) }
        let!(:response) { FactoryBot.create(:response, board: board) }
        scenario "コメント詳細画面が表示される" do
          visit admin_coins_path
          click_on "スレッド一覧"
          click_on "board_responses_#{board.id}"
          click_on "show_response#{response.id}"
          expect(page).to have_content "コメント詳細"
          expect(page).to have_content response.body
          expect(page).to have_content "#{response.user.last_name} #{response.user.first_name}"
        end
      end
    end

    feature "コメント削除" do
      context "認証済み" do
        before do
          sign_in admin
        end
        let(:board) { FactoryBot.create(:board) }
        let!(:response) { FactoryBot.create(:response, board: board) }
        it "コメントを削除できる" do
          visit admin_coins_path
          click_on "スレッド一覧"
          click_on "board_responses_#{board.id}"
          click_on "show_response#{response.id}"
          expect {
            click_on "delete_response#{response.id}"
          }.to change(Response, :count).by(-1)
          expect(page).to have_content "コメントを削除しました"
          expect(page).to have_content "コメント一覧"
        end
      end
    end
  end
end
