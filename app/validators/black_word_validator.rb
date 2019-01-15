class BlackWordValidator < ActiveModel::EachValidator
  class << self
    attr_reader :black_lists
  end

  @black_lists = ["殺す", "死ね", "殺害"]

  def validate_each(record, attribute, value)
    BlackWordValidator.black_lists.each do |black_list|
      if value.include?(black_list)
        record.errors.add(attribute, 'は禁止文言を含んでいます')
        break
      end
    end
  end
end