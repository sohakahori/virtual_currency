require 'rails_helper'

RSpec.describe Admin::AdminsController, type: :controller do

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

  describe 'GET #show' do
    context "認証済み" do
      before do
        sign_in admin
      end
      it "200ステータスコードをレスポンスする" do
        get :show, params: {id: admin.id}
        expect(response).to have_http_status(200)
      end
    end

    context "未認証" do
      it "302ステータスコードをレスポンスする" do
        get :show, params: {id: admin.id}
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'GET #new' do
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

  describe 'POST #create' do
    context "認証済み" do
      before do
        sign_in admin
      end
      it "302ステータスコードをレスポンスする" do
        expect {
          post :create, params: { admin: FactoryBot.attributes_for(:admin) }
        }.to change(Admin, :count).by(1)
        expect(response).to have_http_status(302)
      end
    end

    context "未認証" do
      it "302ステータスコードをレスポンスする" do
        expect {
          post :create, params: { admin: FactoryBot.attributes_for(:admin) }
        }.to change(Admin, :count).by(0)
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:delete_admin) { FactoryBot.create(:admin) }
    context "認証済み" do
      before do
        sign_in admin
      end
      it "302ステータスコードをレスポンスする" do
        expect {
          delete :destroy, params: { id: delete_admin.id }
        }.to change(Admin, :count).by(-1)
        expect(response).to have_http_status(302)
      end
    end

    context "未認証" do
      it "302ステータスコードをレスポンスする" do
        expect {
          delete :destroy, params: { id: delete_admin.id }
        }.to change(Admin, :count).by(0)
        expect(response).to have_http_status(302)
      end
    end
  end
end
