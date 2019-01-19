require 'rails_helper'
require 'concerns/api/login_request_header'

RSpec.describe "Api::V1::Responses", type: :request do
  include Api::LoginRequestHeader

  let(:user) { FactoryBot.create(:user) }
  let!(:board){ FactoryBot.create(:board, title: "悲報、コインチェック") }

  describe "GET /api/v1/board/:board_id/responses" do
    before do
      (0..40).each do |i|
        FactoryBot.create(:response, body: "スレッドコメント#{i}", board: board)
      end
    end
    context "認証済み" do
      it "200ステータスコードを返す" do
        get api_v1_board_responses_path(board), headers: token_sign_in
        expect(response).to have_http_status(200)
        json = JSON.parse(response.body)
        expect(json["responses"].length).to eq 30
        expect(json["responses"][29]["body"]).to eq "スレッドコメント29"
      end
    end

    context "未認証" do
      it "401ステータスコードを返す" do
        get api_v1_board_responses_path(board), headers: {}
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "POST /api/v1/board/:board_id/responses" do
    context "認証済み" do
      it "コメントを作成できる" do
        response_params = {
          response: {
            body:"コメントだよ"
          }
        }
        expect {
          post api_v1_board_responses_path(board), headers: token_sign_in, params: response_params
        }.to change(Response, :count).by(1)
        expect(response).to have_http_status(200)
      end

      it "不正なパラメータ時は400ステータスコードを返す" do
        response_params = {
          response: {
            body: nil
          }
        }
        expect {
          post api_v1_board_responses_path(board), headers: token_sign_in, params: response_params
        }.to change(Response, :count).by(0)
        expect(response).to have_http_status(400)
        json = JSON.parse(response.body)
        expect(json["errors"]["full_messages"]).to include("コメントを入力してください")
      end
    end

    context "未認証" do
      it "401ステータスコードを返す" do
        response_params = {
          response: {
            body:"コメントだよ"
          }
        }
        post api_v1_board_responses_path(board), headers: {}, params: response_params
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "DELETE /api/v1/board/:board_id/responses/id" do
    let!(:board_response){ FactoryBot.create(:response, body: "削除spec", board: board, user: user) }
    let!(:other_user_board_response){ FactoryBot.create(:response, body: "削除spec", board: board) }
    context "認証済み" do
      it "コメントを削除できる" do
        expect {
          delete api_v1_board_response_path(board, board_response), headers: token_sign_in
        }.to change(Response, :count).by(-1)
        expect(response).to have_http_status(200)
      end

      it "自分で作成していないコメントは削除できない" do
        expect {
          delete api_v1_board_response_path(board, other_user_board_response), headers: token_sign_in
        }.to change(Response, :count).by(0)
        expect(response).to have_http_status(400)
      end
    end

    context "未認証" do
      it "コメントを削除できない" do
        expect {
          delete api_v1_board_response_path(board, board_response), headers: {}
        }.to change(Response, :count).by(0)
        expect(response).to have_http_status(401)
      end
    end
  end
end
