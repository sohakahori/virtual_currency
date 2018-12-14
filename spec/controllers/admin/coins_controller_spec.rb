require 'rails_helper'

RSpec.describe Admin::CoinsController, type: :controller do

  let(:admin) { FactoryBot.create(:admin) }

  describe 'GET #index' do
    context "認証済み" do
      before do
        sign_in admin
      end
      it "200ステータスコードをレスポンスする" do
        get :index
        expect(response).to have_http_status(200)
      end
    end

    context "未認証" do
      it "302ステータスコードをレスポンスする" do
        get :index
        expect(response).to have_http_status(302)
      end
    end
  end
end
