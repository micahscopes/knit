require 'bundler'
require 'rspec'
require 'rake'
require 'rake/clean'
Bundler.require

RSpec.describe Knit do
  example "merge hashes" do
    a = {1=>2,2=>3}
    b = {2=>4,3=>5}
    c = {1=>2, 2=>[3, 4], 3=>5}
    expect(a.knit(b)).to eq(c)
  end

end
