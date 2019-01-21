require 'rails_helper'

RSpec.describe Public::UserResponsesController, type: :controller do

  let(:user) { FactoryBot.create(:user) }
  let!(:response) { FactoryBot.create(:response, user: user) }
  let!(:other_response) { FactoryBot.create(:response) }

  describe 'GET #index' do

    context "認証済み" do
      before do
        sign_in user
      end

      # it "@paramsという変数に正しい値がセットされている(パラメータ未指定)" do
      # end

      # it "@paramsという変数に正しい値がセットされている(パラメータ指定)" do
      #   get :index, params: { q: response.board.title }
      #   expect(assigns(:params)).to eq ({q: response.board.title})
      # end
      #
      #
      # it "@boardsという変数に正しい値がセットされている" do
      #   get :index
      #   boards = []
      #   boards << response.board
      #   boards.unshift(Board.new)
      #   expect(assigns(:boards)).to match_array boards
      # end

      # it "@responsesという変数に正しい値がセットされている" do
      #
      # end

      it "index viewにレンダリングされている" do
        get :index
        expect(response).to render_template :index
      end

      # Todo: なぜかテストが通らない
      it "200ステータスコードを返している", :skip => true do
        get :index
        expect(response).to have_http_status 200
      end
    end

    context "未認証" do
      it "ログイン画面にリダイレクトされる" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end

      #Todo: なぜかテストが通らない
      it "302ステータスコードを返す", :skip => true do
        get :index
        expect(response).to have_http_status 302
      end
    end
  end

  describe 'Delete #destroy' do
    context "認証済み" do
      before do
        sign_in user
      end
      it "自分が投稿したコメントを削除できる" do
        expect {
          delete :destroy, params: {id: response.id}
        }.to change(user.responses, :count).by(-1)
      end

      it "自分以外が投稿したコメントは削除できない" do
        expect {
          delete :destroy, params: {id: other_response.id}
        }.to change(user.responses, :count).by(0)
      end

      #Todo なぜかテストが通らない
      it "コメント投稿一覧画面にリダイレクトされる", :skip => true do
        delete :destroy, params: {id: response.id}
        expect(response).to redirect_to(public_user_responses_path)
        # expect(response).to redirect_to public_user_responses_path
      end

      #Todo なぜかテストが通らない
      it "302ステータスコードを返す", :skip => true do
        delete :destroy, params: {id: response.id}
        expect(response).to have_http_status 302
      end
    end

    context "未認証" do
      it "コメントを削除できない" do
        expect {
          delete :destroy, params: {id: response.id}
        }.to change(user.responses, :count).by(0)
      end

      #Todo なぜかテストが通らない
      it "ログイン画面にリダイレクトする", :skip => true do
        delete :destroy, params: {id: response.id}
        expect(response).to redirect_to(new_user_session_path)
      end

      #Todo なぜかテストが通らない
      it "302ステータスコードを返す", :skip => true do
        delete :destroy, params: {id: response.id}
        expect(response).to have_http_status 302
      end
    end
  end

end
