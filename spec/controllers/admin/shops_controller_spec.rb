require 'rails_helper'

RSpec.describe Admin::ShopsController, type: :controller do

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

  describe "GET #show" do
    let(:shop) { FactoryBot.create(:shop) }
    context "認証済み" do
      before do
        sign_in admin
      end
      it "200ステータスコードをレスポンスする" do
        get :show, params: {id: shop.id}
        expect(response).to have_http_status(200)
      end
    end

    context "未認証" do
      it "302ステータスコードをレスポンスする" do
        get :show, params: {id: shop.id}
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "GET #new" do
    let(:shop) { FactoryBot.create(:shop) }
    context "認証済み" do
      before do
        sign_in admin
      end
      it "200ステータスコードをレスポンスする" do
        get :new
        expect(response).to have_http_status(200)
      end
    end

    context "未認証" do
      it "302ステータスコードをレスポンスする" do
        get :new
        expect(response).to have_http_status(302)
      end
    end
  end

  describe "post #create" do
    let(:shop_params) { FactoryBot.attributes_for(:shop) }
    context "認証済み" do
      before do
        sign_in admin
      end
      it "302ステータスコードをレスポンスする" do
        expect {
          post :create, params:  { shop: shop_params }
        }.to change(Shop, :count).by(1)
        expect(response).to have_http_status(302)
      end
    end

    context "未認証" do
      it "302ステータスコードをレスポンスする" do
        expect {
          post :create, params: shop_params
        }.to change(Shop, :count).by(0)
        expect(response).to have_http_status(302)
      end
    end
  end
end
