require "knit/version"

module Knit
  module Hash
    public
    def knit(other)
     return self if other == nil
     return other.knit(self, true) if !other.respond_to?(:keys)
     self.merge(other) do |key, a, b|
       knit = a if b.is_a? NilClass
       knit = b if a.is_a? NilClass
       knit = if a.respond_to?(:keys) && b.respond_to?(:keys)
         a.to_h.knit(b.to_h)
       elsif a.respond_to?(:knit) && b.respond_to?(:knit)
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

    def knit!(other)
      self.replace(self.knit(other))
    end
  end

  module Array
    def knit(other,reverse=false)
      unless other.respond_to? :keys
        knit = reverse ? [other]+self : self+[other]
        knit = self+[other].flatten(1).map{|x|  x.respond_to?(:keys) ? x.to_h : x}
      else
        other = other.to_h
        knit = ([self]+[other]).flatten(1) #.map{|a| a.to_h if a.respond_to? :keys}
        knit = knit.partition{|obj| obj.respond_to? :keys}
        knit = [knit[1],knit[0].reduce{|a,b| a.knit(b)}]
        knit.reverse! if reverse
        knit = knit.flatten(1)
      end
      if block_given?
        yield knit
      else
        knit
      end
    end

    def knit!(other)
      self.replace(self.knit(other))
    end
  end
end

# todo: implement for Set objects

Hash.include Knit::Hash
Array.include Knit::Array
