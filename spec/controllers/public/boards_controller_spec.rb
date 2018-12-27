require 'rails_helper'

RSpec.describe Public::BoardsController, type: :controller do

  let(:user) { FactoryBot.create(:user) }
  describe "GET index" do
    context "認証済み" do
      before do
        sign_in user
        create_boards
      end
      let(:boards) { Board.page("1").per(Public::ApplicationController::PER_PAGE) }

      it "@boardsという変数が正しくセットされている" do
        get :index
        expect(assigns[:boards]).to eq boards
      end

      it "index viewにレンダリングされる" do
        get :index
        expect(response).to render_template :index
      end

      it "200ステータスコードを返す" do
        get :index
        expect(response).to have_http_status 200
      end
    end

    context "未認証" do
      before do
        create_boards
      end

      it "ログイン画面にリダイレクトされる" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end

      it "302ステータスコードを返す" do
        get :index
        expect(response).to have_http_status 302
      end
    end
  end

  describe "GET new" do
    context "認証済み" do
      before do
        @board = Board.new
        @board.responses.build
        sign_in user
      end
      it "@boardという変数が正しくセットされている" do
        get :new
        expect(assigns(:board)).to be_a_new(Board)
      end

      it "new viewにレンダリングされる" do
        get :new
        expect(response).to render_template :new
      end

      it "200ステータスコードを返す" do
        get :new
        expect(response).to have_http_status 200
      end
    end

    context "未認証" do
      it "ログイン画面にリダイレクトされる" do
        get :new
        expect(response).to redirect_to new_user_session_path
      end

      it "302ステータスコードを返す" do
        get :new
        expect(response).to have_http_status 302
      end
    end
  end

  describe "POST create" do
    context "認証済みかつDBに保存される" do
      before do
        sign_in user
        @board_params = get_valid_board_params
      end

      it "DBにスレッドが・レスポンスが保存される" do
        before_responses_count = Response.count
        expect {
          post :create,
          params: @board_params
        }.to change(Board, :count).by(1)
        expect(Response.count).to eq (before_responses_count + 1)
      end

      it "一覧画面にリダイレクトする" do
        post :create, params: @board_params
        expect(response).to redirect_to public_boards_path
      end

      it "302ステータスコードを返す" do
        post :create, params: @board_params
        expect(response).to have_http_status 302
      end
    end

    context "認証済みかつDBに保存されない" do
      before do
        sign_in user
        @board_params = {
          "board": {
            title: nil,
            responses_attributes: [
              body: nil
            ]
          }
        }
      end

      it "DBにスレッド・レスポンス保存されない" do
        before_responses_count = Response.count
        expect {
          post :create,
               params: @board_params
        }.to change(Board, :count).by(0)
        expect(Response.count).to eq (before_responses_count)
      end

      it "new viewにレンダリングする" do
        post :create,
             params: @board_params
        expect(response).to render_template :new
      end

      it "200ステータスコードを返す" do
        post :create,
             params: @board_params
        expect(response).to have_http_status 200
      end
    end

    context "未認証" do
      it "ログイン画面にリダイレクトされる" do
        post :create,
             params: get_valid_board_params
        expect(response).to redirect_to new_user_session_path
      end
    end

  end


  def create_boards
    (1..10).each do
      FactoryBot.create(:board)
    end
  end

  def get_valid_board_params
    {
      "board": {
        title: "createスレッド",
        responses_attributes: [
          body: "createコメント"
        ]
      }
    }
  end
end
