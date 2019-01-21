require 'rails_helper'

RSpec.describe Admin, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  #
  context "バリデーション適用" do # deviseのバリデーションは省略
    it "first_nameが未入力の時はバリデーションが適用される" do
      admin = FactoryBot.build(:admin, first_name: nil)
      admin.valid?
      expect(admin.errors.messages[:first_name]).to include("を入力してください")
    end

    it "last_nameが未入力の時はバリデーションが適用される" do
      admin = FactoryBot.build(:admin, last_name: nil)
      admin.valid?
      expect(admin.errors.messages[:last_name]).to include("を入力してください")
    end
  end

  context "バリデーション未適用" do
    it "入力値が正しい時はバリデーションが適用されない" do
      admin = FactoryBot.build(:admin, first_name: "first_name", last_name: "last_name", email: "test@test.com", password: "testtest")
      expect(admin.valid?).to eq true
    end
  end
end
