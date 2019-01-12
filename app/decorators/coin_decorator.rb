module CoinDecorator
  def format_market_cap_jpy
    number_to_currency(self.market_cap_jpy, unit: "JPY")
  end

  def format_price
    number_to_currency(self.price, unit: "JPY")
  end

  def format_updated_at
    self.updated_at.strftime('%Y年%m月%d日 %H:%M:%S')
  end

end
