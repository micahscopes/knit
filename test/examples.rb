require 'bundler'
require 'rspec'
require 'rake'
require 'rake/clean'
Bundler.require

RSpec.describe Knit do
  example "knit hashes" do
    a = {1=>2,2=>3}
    b = {2=>4,3=>5}
    c = {1=>2, 2=>[3, 4], 3=>5}
    expect(a.knit(b)).to eq(c)
  end

  example "knit arrays" do
    a = [1,2,3]
    b = [4,5]
    c = [1,2,3,4,5]
    expect(a.knit(b)).to eq(c)
  end

  example "knit hash into array" do
    expect(  [1].knit({2=>3})  ).to eq(  [1,{2=>3}]  )
  end

  example "knit array into hash" do
    expect(  {1 => 2}.knit([3])  ).to eq(  [{1=>2},3]  )
  end
end
