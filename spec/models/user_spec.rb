require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  context "バリデーション適用" do # deviseのバリデーションは省略
    it "first_nameが未入力時はバリデーションが適用される" do
      user = FactoryBot.build(:user, first_name: nil)
      user.valid?
      expect(user.errors.messages[:first_name]).to include("を入力してください")
    end

    it "last_nameが未入力時はバリデーションが適用される" do
      user = FactoryBot.build(:user, last_name: nil)
      user.valid?
      expect(user.errors.messages[:last_name]).to include("を入力してください")
    end

    it "nicknameが未入力時はバリデーションが適用される" do
      user = FactoryBot.build(:user, nickname: nil)
      user.valid?
      expect(user.errors.messages[:nickname]).to include("を入力してください")
    end
  end

  context "バリデーション未適用" do
    it "入力値が正しい時はバリデーションが適用されない" do
      admin = FactoryBot.build(:admin)
      expect(admin.valid?).to eq true
    end
  end
end
