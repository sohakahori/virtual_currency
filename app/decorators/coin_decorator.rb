module CoinDecorator

  def format_market_cap_jpy
    number_to_currency(self.market_cap_jpy, unit: "JPY")
  end
end
