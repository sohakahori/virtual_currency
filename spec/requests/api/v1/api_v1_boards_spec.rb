require 'rails_helper'
require 'concerns/api/login_request_header'

RSpec.describe "Api::V1::Boards", type: :request do

  include Devise::Test::IntegrationHelpers
  include Api::LoginRequestHeader


  let(:user) { FactoryBot.create(:user) }
  let!(:board){ FactoryBot.create(:board, title: "悲報、コインチェック") }
  before do
    (1..40).each do
      FactoryBot.create(:board)
    end
  end

  describe "GET /api/v1/boards" do
    context "認証済み" do
      it "200ステータスコードを返す" do
        get api_v1_boards_path, headers: token_sign_in
        expect(response).to have_http_status(200)
      end

      it "200ステータスコードを返す(パラメータあり)" do
        get api_v1_boards_path, params: {q: "コインチェック"}, headers: token_sign_in
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)["boards"].count).to eq 1
        expect(JSON.parse(response.body)["boards"][0]["title"]).to eq board.title
      end
    end

    context "未認証" do
      it "401ステータスコードを返す" do
        get api_v1_boards_path
        expect(response).to have_http_status(401)
      end
    end
  end

  describe "POST /api/v1/boards", forcusss: true do
    context "認証済み" do
      it "スレッドが作成される" do
        before_responses_count = Response.count
        params = {
            board: {
                title: "朗報、コインチエック",
                responses_attributes: [
                    {
                        body: "コインチェック復活!"
                    }
                ]
            }
        }
        expect {
          post api_v1_boards_path, params: params, headers: token_sign_in
        }.to change(Board, :count).by(1)
        expect(before_responses_count + 1).to eq Response.count
        expect(response).to have_http_status(200)
      end
    end

    context "未認証" do
      it "スレッドが作成されない" do
        before_responses_count = Response.count
        params = {
            board: {
                title: "朗報、コインチエック",
                responses_attributes: [
                    {
                        body: "コインチェック復活!"
                    }
                ]
            }
        }
        expect {
          post api_v1_boards_path, params: params, headers: {}
        }.to change(Board, :count).by(0)
        expect(before_responses_count).to eq Response.count
        expect(response).to have_http_status(401)
      end
    end
  end
end


