require 'rails_helper'

RSpec.describe Response, type: :model do
  context "バリデーション適用" do
    it "bodyが未入力の時はバリデーションが適用される" do
      response = FactoryBot.build(:response, body: nil)
      response.valid?
      expect(response.errors.messages[:body]).to include("を入力してください")
    end

    it "bodyが51字以上入力時はバリデーションが適用される" do
      response = FactoryBot.build(:response, body: ("a" * 51))
      response.valid?
      expect(response.errors.messages[:body]).to include("は50文字以内で入力してください")
    end
  end

  context "バリデーション未適用" do
    it "正常な値が入力された時はバリデーションが適用されないこと" do
      response = FactoryBot.build(:response, body: ("a" * 50))
      response.valid?
      expect(response).to be_valid
    end
  end
end
