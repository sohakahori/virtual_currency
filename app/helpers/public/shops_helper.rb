module Public::ShopsHelper
  def get_coin_check_box_tag coin, coin_ids
    Array(coin_ids).include?(coin.id.to_s) ? check_box_tag("coin_ids[]", coin.id, true, id: "coin_#{coin.id}") : check_box_tag("coin_ids[]", coin.id, false, id: "coin_#{coin.id}")
  end
end
