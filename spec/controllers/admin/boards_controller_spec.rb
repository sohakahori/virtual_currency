require 'rails_helper'

RSpec.describe Admin::BoardsController, type: :controller do

  let(:admin) { FactoryBot.create(:admin) }
  describe "GET #index" do
    context "認証済み" do
      before do
        sign_in admin
        (1..10).each do
          FactoryBot.create(:board)
        end
      end
      it "@boardsという変数が正しくセットされている" do
        get :index
        boards = Board.includes(:user).page(1).per(Admin::ApplicationController::PER_PAGE)
        expect(assigns(:boards)).to eq boards
      end
      it "index viewにレンダリングされている" do
        get :index
        expect(response).to render_template :index
      end
      it "200スレータスコードを返している" do
        get :index
        expect(response).to have_http_status 200
      end
    end

    context "未認証" do
      it "ログイン画面にリダイレクトされている" do
        get :index
        expect(response).to redirect_to new_admin_session_path
      end

      it "302ステータスコードを返している" do
        get :index
        expect(response).to have_http_status 302
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:board) { FactoryBot.create(:board) }
    context "認証済み" do
      before do
        sign_in admin
      end
      it "Boardを削除できている" do
        expect {
          delete :destroy, params: { id: board.id }
        }.to change(Board, :count).by(-1)
      end
      it "board一覧画面にリダイレクトしている" do
        delete :destroy, params: { id: board.id }
        expect(response).to redirect_to admin_boards_path
      end
      it "302ステータスコードを返している" do
        delete :destroy, params: { id: board.id }
        expect(response).to have_http_status 302
      end
    end

    context "未認証" do
      it "Boardが削除されていない" do
        expect {
          delete :destroy, params: { id: board.id }
        }.to change(Board, :count).by(0)
      end
      it "ログイン画面にリダイレクトしている" do
        delete :destroy, params: { id: board.id }
        expect(response).to redirect_to new_admin_session_path
      end
      it "302ステータスコードを返している" do
        delete :destroy, params: { id: board.id }
        expect(response).to have_http_status 302
      end
    end
  end
end
