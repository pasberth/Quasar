module Quasar

  extend self

  def blackhole
    @blackhole ||= Blackhole.new
  end

  def darkmatter
    @darkmatter ||= DarkMatter.new
  end

  class Universe

    BIG_CRUNCH = -> x { x }

    def initialize eras = []
      @value = eras.reverse_each.inject(BIG_CRUNCH) do |nxt, era|
        -> x { nxt.call(era.call(x)) }
      end
    end

    def value a
      @value.call(a)
    end
  end

  class Blackhole < BasicObject

    def respond_to? msg
      if [:to_ary].include? msg.to_sym
        false
      else
        super
      end
    end

    def method_missing msg, *args, &block
      self
    end
  end

  class DarkMatter < BasicObject; end
end

# example
include Quasar
anUniverse = Universe.new([ -> x { p x },
                            -> y { p y + 1 },
                            -> z { p z + 2 }
                          ])
anUniverse.value(0)
puts blackhole.x.y.z
puts Quasar.blackhole.x.y.z
