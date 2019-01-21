require 'rails_helper'

RSpec.describe Board, type: :model do
  context "バリデーション適用" do
    it "titleが未入力の時はバリデーションが適用される" do
      board = FactoryBot.build(:board, title: nil)
      board.valid?
      expect(board.errors.messages[:title]).to include("を入力してください")
    end

    it "titleが21字以上入力時はバリデーションが適用される" do
      board = FactoryBot.build(:board, title: ("a" * 21))
      board.valid?
      expect(board.errors.messages[:title]).to include("は20文字以内で入力してください")
    end
  end

  context "バリデーション未適用" do
    it "正常な値が入力された時はバリデーションが適用されないこと" do
      board = FactoryBot.build(:board, title: ("a" * 20))
      board.valid?
      expect(board).to be_valid
    end
  end
end
