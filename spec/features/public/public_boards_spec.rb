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
end
