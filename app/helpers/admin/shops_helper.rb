module Admin::ShopsHelper
  def get_coin_check_box_tag coind_id
    @coin_ids.include?(coind_id.to_s) ? check_box_tag("coin_ids[]", coind_id, true, id: "coin_#{coind_id}") : check_box_tag("coin_ids[]", coind_id, false, id: "coin_#{coind_id}")
  end
end
