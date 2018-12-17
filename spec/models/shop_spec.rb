require 'rails_helper'

RSpec.describe Shop, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  context "バリデーション適用" do
    it "nameが未入力の時はバリデーションが適用される" do
      shop = FactoryBot.build(:shop, name: nil)
      shop.valid?
      expect(shop.errors.messages[:name]).to include("を入力してください")
    end

    it "addressが未入力の時はバリデーションが適用される" do
      shop = FactoryBot.build(:shop, address: nil)
      shop.valid?
      expect(shop.errors.messages[:address]).to include("を入力してください")
    end

    it "companyが未入力の時はバリデーションが適用される" do
      shop = FactoryBot.build(:shop, company: nil)
      shop.valid?
      expect(shop.errors.messages[:company]).to include("を入力してください")
    end

  end

end
