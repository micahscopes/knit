require "knit/version"

module Knit
  module Hash
    def knit(other)
     return self if other == nil
     return other.knit(self) if !other.is_a?(Hash)
     self.merge(other) do |key, a, b|
       knit = a if b.is_a? NilClass
       knit = b if a.is_a? NilClass
       knit = if a.is_a?(Hash) && b.is_a?(Hash)
         a.knit(b)
       else
         [a,b].flatten(1)
       end
       if block_given?
         yield knit,key
       else
         knit
       end
     end
    end
  end

  module Array
    def knit(other)
      knit = ([self]+[other]).flatten(1)
      knit = knit.partition{|obj| obj.is_a?(Hash)}
      knit = [knit[1],knit[0].reduce{|a,b| a.knit(b)}].flatten(1)
      if block_given?
        yield knit
      else
        knit
      end
    end
  end
end

Hash.include Knit::Hash
Array.include Knit::Array
