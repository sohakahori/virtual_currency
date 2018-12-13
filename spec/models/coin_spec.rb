require 'rails_helper'

RSpec.describe Coin, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  let!(:coin) { FactoryBot.create(:coin, name: "ビットコイン", market_rank: 1) }
  context "バリデーション適用" do
    it "nameが同値の場合はバリデーションが適用されること" do
      other_coin = FactoryBot.build(:coin, name: coin.name)
      other_coin.valid?
      expect(other_coin.errors.messages[:name]).to include("はすでに存在します")
    end

    it "market_rankが同値の場合はバリデーションが適用されること" do
      other_coin = FactoryBot.build(:coin, market_rank: coin.market_rank)
      other_coin.valid?
      expect(other_coin.errors.messages[:market_rank]).to include("はすでに存在します")
    end

    it "market_rankが文字列の場合はバリデーションが適用されること" do
      other_coin = FactoryBot.build(:coin, market_rank: "仮想通貨")
      other_coin.valid?
      expect(other_coin.errors.messages[:market_rank]).to include("は数値で入力してください")
    end
  end

  context "バリデーション未適用" do
    it "nameが一意の場合はバリデーションが適用されないこと" do
      other_coin = FactoryBot.build(:coin, name: "XRP")
      other_coin.valid?
      expect(other_coin.errors.messages[:name]).not_to include("はすでに存在します")
    end

    it "market_rankが一意の場合はバリデーションが適用されないこと" do
      other_coin = FactoryBot.build(:coin, market_rank: coin.market_rank + 1)
      other_coin.valid?
      expect(other_coin.errors.messages[:market_rank]).not_to include("はすでに存在します")
    end

    it "market_rankが数値の場合はバリデーションが適用されないこと" do
      other_coin = FactoryBot.build(:coin, market_rank: coin.market_rank + 1)
      other_coin.valid?
      expect(other_coin.errors.messages[:market_rank]).not_to include("は数値で入力してください")
    end
  end
end
