require 'rails_helper'

RSpec.describe Coin, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  let!(:coin) { FactoryBot.create(:coin, name: "ビットコイン", rank: 1) }
  context "バリデーション適用" do
    it "nameが同値の場合はバリデーションが適用されること" do
      other_coin = FactoryBot.build(:coin, name: coin.name)
      other_coin.valid?
      expect(other_coin.errors.messages[:name]).to include("はすでに存在します")
    end

    it "rankが同値の場合はバリデーションが適用されること" do
      other_coin = FactoryBot.build(:coin, rank: coin.rank)
      other_coin.valid?
      expect(other_coin.errors.messages[:rank]).to include("はすでに存在します")
    end

    it "rankが文字列の場合はバリデーションが適用されること" do
      other_coin = FactoryBot.build(:coin, rank: "仮想通貨")
      other_coin.valid?
      expect(other_coin.errors.messages[:rank]).to include("は数値で入力してください")
    end
  end

  context "バリデーション未適用" do
    it "nameが一意の場合はバリデーションが適用されないこと" do
      other_coin = FactoryBot.build(:coin, name: "XRP")
      other_coin.valid?
      expect(other_coin.errors.messages[:name]).not_to include("はすでに存在します")
    end

    it "rankが一意の場合はバリデーションが適用されないこと" do
      other_coin = FactoryBot.build(:coin, rank: coin.rank + 1)
      other_coin.valid?
      expect(other_coin.errors.messages[:rank]).not_to include("はすでに存在します")
    end

    it "rankが数値の場合はバリデーションが適用されないこと" do
      other_coin = FactoryBot.build(:coin, rank: coin.rank + 1)
      other_coin.valid?
      expect(other_coin.errors.messages[:rank]).not_to include("は数値で入力してください")
    end
  end
end
