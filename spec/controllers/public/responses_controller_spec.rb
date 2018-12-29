require 'rails_helper'

RSpec.describe Public::ResponsesController, type: :controller do

  let(:user) { FactoryBot.create(:user) }
  let(:board) { FactoryBot.create(:board) }

  describe "GET #index" do
    let!(:response1) { FactoryBot.create(:response, board: board) }
    let!(:response2) { FactoryBot.create(:response, board: board) }

    context "認証済み" do

      before do
        sign_in user
      end

      it "@responsesという変数が正しくセットされている" do
        get :index, params: { board_id: board.id }
        responses = get_board(board.id)
                       .responses
                       .includes(:user)
                       .page(1)
                       .per(Public::ApplicationController::RESPONSE_PER_PAGE)
        expect(assigns(:responses)).to eq responses
      end

      it "index viewにレンダリングされている" do
        get :index, params: { board_id: board.id }
        expect(response).to render_template :index
      end

      it "200ステータスコードを返している" do
        get :index, params: { board_id: board.id }
        expect(response).to have_http_status 200
      end
    end

    context "未認証" do
      it "ログイン画面にリダイレクトされる" do
        get :index, params: { board_id: board.id }
        expect(response).to redirect_to(new_user_session_path)
      end

      it "302ステータスコードを返している" do
        get :index, params: { board_id: board.id }
        expect(response).to have_http_status 302
      end
    end
  end

  describe "GET #new" do
    context "認証済み" do
      before do
        sign_in user
      end
      it "@responseという変数が正しくセットされている" do
        get :new, params: { board_id: board.id }
        expect(assigns(:response)).to be_a_new(Response)
      end

      it "new viewにレンダリングされている" do
        get :new, params: { board_id: board.id }
        expect(response).to render_template :new
      end

      it "200ステータスコードを返している" do
        get :new, params: { board_id: board.id }
        expect(response).to have_http_status 200
      end
    end

    context "未認証" do
      it "ログイン画面にリダイレクトされる" do
        get :new, params: { board_id: board.id }
        expect(response).to redirect_to new_user_session_path
      end

      it "302ステータスコードを返す" do
        get :new, params: { board_id: board.id }
        expect(response).to have_http_status 302
      end
    end
  end

  describe "POST #create" do
    let(:response_params) { FactoryBot.attributes_for(:response) }
    context "認証済みかつ保存に成功したとき" do
      before do
        sign_in user
      end
      it "Responseに登録できる" do
        expect {
          post :create, params: {
            board_id: board.id,
            response: response_params
          }
        }.to change(Response, :count).by(1)

      end

      it "コメント一覧画面にリダイレクトされている" do
        post :create, params: {
          board_id: board.id,
          response: response_params
        }
        expect(response).to redirect_to public_board_responses_path
      end

      it "302ステータスコードを返す" do
        post :create, params: {
          board_id: board.id,
          response: response_params
        }
        expect(response).to have_http_status 302
      end

    end

    context "認証済みかつ保存に失敗したとき" do
      before do
        sign_in user
      end
      it "Responseに登録できていない" do
        expect {
          post :create, params: {
            board_id: board.id,
            response: {
              body: nil
            }
          }
        }.to change(Response, :count).by(0)
      end

      it "new viewにレンダリングされる" do
        post :create, params: {
          board_id: board.id,
          response: {
            body: nil
          }
        }
        expect(response).to render_template :new
      end

      it "200ステータスコードを返す" do
        post :create, params: {
          board_id: board.id,
          response: {
            body: nil
          }
        }
        expect(response).to have_http_status 200
      end
    end

    context "未認証" do
      it "ログイン画面にリダイレクトされる" do
        post :create, params: {
          board_id: board.id,
          response: response_params
        }
        expect(response).to redirect_to new_user_session_path
      end

      it "Responseに登録できていない" do
        expect {
          post :create, params: {
            board_id: board.id,
            response: response_params
          }
        }.to change(Response, :count).by(0)
      end

      it "302スタータスコードを返す" do
        post :create, params: {
          board_id: board.id,
          response: response_params
        }
        expect(response).to have_http_status 302
      end

    end
  end

  describe "Delete #destroy" do
    let!(:delete_response) { FactoryBot.create(:response, board: board, user: user) }
    context "認証済みかつ削除できる" do
      before do
        sign_in user
      end

      it "Responseを削除できる" do
        expect {
          delete :destroy, params: {id: delete_response.id}
        }.to change(Response, :count).by(-1)

      end

      it "口コミ一覧画面にリダイレクトする" do
        delete :destroy, params: {id: delete_response.id}
        expect(response).to redirect_to public_board_responses_path(board)
      end

      it "302ステータスコードを返す" do
        delete :destroy, params: {id: delete_response.id}
        expect(response).to have_http_status 302
      end
    end

    # Todo: /public/boards/:board_id/responses/id　のuriにする必要あり(一旦保留)
    pending "認証済みかつ削除失敗時" do
      before do
        sign_in user
      end
      it "Responseを削除できない" do
        expect {
          delete :destroy, params: {id: delete_response.id + 1}
        }.to change(Response, :count).by(0)
      end

      it "口コミ一覧画面リサイレクトする" do
        delete :destroy, params: {id: delete_response.id + 1}
        expect(response).to redirect_to public_board_responses_path(board)
      end

      it "302ステータスコードを返す" do
        delete :destroy, params: {id: delete_response.id + 1}
        expect(response).to have_http_status 302
      end
    end

    context "未認証" do
      it "Responseを削除できない" do
        expect {
          delete :destroy, params: {id: delete_response.id}
        }.to change(Response, :count).by(0)
      end

      it "ログイン画面にリダイレクトする" do
        delete :destroy, params: {id: delete_response.id}
        expect(response).to redirect_to new_user_session_path
      end

      it "302ステータスコードを返す" do
        delete :destroy, params: {id: delete_response.id}
        expect(response).to have_http_status 302
      end
    end
  end

  def get_board id
    Board.find(id)
  end
end
