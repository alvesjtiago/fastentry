require 'rails_helper'

describe Fastentry do
  it "should return a default Fastentry cache instance" do
    expect(Fastentry.cache).to be_a_kind_of(Fastentry::DefaultCache)
  end
end
