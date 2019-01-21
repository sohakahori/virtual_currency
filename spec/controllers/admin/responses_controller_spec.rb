require 'rails_helper'

RSpec.describe Admin::ResponsesController, type: :controller do

  let(:admin) { FactoryBot.create(:admin) }
  let(:board){ FactoryBot.create(:board) }
  let!(:board_response){ FactoryBot.create(:response, board: board) }

  describe "GET #index" do
    context "認証済み" do
      before do
        sign_in admin
      end
      it "@responsesという変数が正しくセットされている" do
        get :index, params: { board_id: board.id }
        responses = board.responses.includes(:user).page(1).per(Admin::ApplicationController::PER_PAGE)
        expect(assigns(:responses)).to eq responses
      end

      it "index viewがレンダリングされている" do
        get :index, params: { board_id: board.id }
        expect(response).to render_template :index
      end

      it "200ステータスコードをレスポンスする" do
        get :index, params: { board_id: board.id }
        expect(response).to have_http_status 200
      end
    end

    context "未認証" do
      it "ログイン画面にリダイレクトする" do
        get :index, params: { board_id: board.id }
        expect(response).to redirect_to new_admin_session_path
      end

      it "302ステータスコードをレスポンスする" do
        get :index, params: { board_id: board.id }
        expect(response).to have_http_status 302
      end
    end
  end

  describe "GET #show" do
    context "認証済み" do
      before do
        sign_in admin
      end
      it "@responseという変数が正しくセットされている" do
        get :show, params: {
          board_id: board.id,
          id: board_response.id
        }
        expect(assigns(:response)).to eq board_response
      end

      it "show viewにレンダリングされている" do
        get :show, params: {
          board_id: board.id,
          id: board_response.id
        }
        expect(response).to render_template :show
      end

      it "200ステータスコードを返す" do
        get :show, params: {
          board_id: board.id,
          id: board_response.id
        }
        expect(response).to have_http_status 200
      end
    end

    context "未認証" do
      it "ログイン画面にリダイレクトする" do
        get :show, params: {
          board_id: board.id,
          id: board_response.id
        }
        expect(response).to redirect_to new_admin_session_path
      end

      it "302ステータスコードを返す" do
        get :show, params: {
          board_id: board.id,
          id: board_response.id
        }
        expect(response).to have_http_status 302
      end
    end

    describe "DELETE #destroy" do
      context "認証済み" do
        before do
          sign_in admin
        end
        it "Responseを削除する" do
          expect {
            delete :destroy, params: {
              board_id: board.id,
              id: board_response.id
            }
          }.to change(Response, :count).by(-1)
        end

        it "コメント一覧画面にリダイレクトする" do
          delete :destroy, params: {
            board_id: board.id,
            id: board_response.id
          }
          expect(response).to redirect_to admin_board_responses_path(board)
        end

        it "302ステータスコードを返す" do
          delete :destroy, params: {
            board_id: board.id,
            id: board_response.id
          }
          expect(response).to have_http_status 302
        end
      end

      context "未認証" do
        it "Responseを削除されない" do
          expect {
            delete :destroy, params: {
              board_id: board.id,
              id: board_response.id
            }
          }.to change(Response, :count).by(0)
        end

        it "ログイン画面にリダレクトする" do
          delete :destroy, params: {
            board_id: board.id,
            id: board_response.id
          }
          expect(response).to redirect_to new_admin_session_path
        end

        it "302ステータスコードを返す" do
          delete :destroy, params: {
            board_id: board.id,
            id: board_response.id
          }
          expect(response).to have_http_status 302
        end
      end
    end
  end
end
