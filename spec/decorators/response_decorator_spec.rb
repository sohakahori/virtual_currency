require 'rails_helper'

RSpec.describe ResponseDecorator do
  let(:response) { Response.new.extend ResponseDecorator }
  subject { response }
  it { should be_a Response }
end
