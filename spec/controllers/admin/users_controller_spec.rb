require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do

  let(:admin) { FactoryBot.create(:admin) }
   describe "Get #index" do
     before do
       (1..40).each do |i|
         FactoryBot.create(:user)
       end
     end
     context "認証済み" do
       it "200ステータスコードをレスポンスする" do
         sign_in admin
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

  describe "Get #destroy" do
    before do
      (1..40).each do |i|
        FactoryBot.create(:user)
      end
    end
    let(:user) { FactoryBot.create(:user) }
    context "認証済み" do
      it "deleted_atがnilでない" do
        sign_in admin
        delete :destroy, params: {
            id: user.id
          }
        expect(user.reload.deleted_at).not_to be nil
        expect(response).to have_http_status(302)
      end
    end

    context "未認証" do
      it "302ステータスコードをレスポンスする" do
        delete :destroy, params: {
          id: user.id
        }
        expect(user.reload.deleted_at).to be nil
        expect(response).to have_http_status(302)
      end
    end
  end
end
