require 'rails_helper'

RSpec.describe BoardDecorator do
  let(:board) { Board.new.extend BoardDecorator }
  subject { board }
  it { should be_a Board }
end
