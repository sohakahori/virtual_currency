require 'rails_helper'

RSpec.describe CoinDecorator do
  let(:coin) { Coin.new.extend CoinDecorator }
  subject { coin }
  it { should be_a Coin }
end
