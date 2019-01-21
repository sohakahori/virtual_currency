require 'rails_helper'

RSpec.describe Public::CoinsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe 'GET #index' do
    context "認証済み" do
      before do
        sign_in user
      end
      it "200ステータスコードをレスポンスする" do
        get :index
        expect(response).to have_http_status(200)
      end
    end

    context "未認証" do
      it "200ステータスコードをレスポンスする" do
        get :index
        expect(response).to have_http_status(200)
      end
    end
  end
end
