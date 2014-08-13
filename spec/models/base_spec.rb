require 'rails_helper'

RSpec.describe Base, :type => :model do

  before(:each) do
  end 

  it "can be created" do
    base = Base.create(name: "chompy")

    expect(base).not_to eq(nil)
  end
end
