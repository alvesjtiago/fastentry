require 'rails_helper'

describe Fastentry do
  it "should return a default Fastentry cache instance" do
    expect(Fastentry.cache).to be_a_kind_of(Fastentry::DefaultCache)
  end

  it "should return the correct number of cached keys" do
    Rails.cache.write("city", "Porto")
    expect(Fastentry.cache.keys.size).to eq(1)
  end
end
