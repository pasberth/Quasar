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
      @eras = eras
      @value = build_value(eras)
    end

    def value a
      @value.call(a)
    end

    def back_to at
      Universe.new(@eras[at..-1])
    end

    private

      def build_value eras = @eras
        eras.reverse_each.inject(BIG_CRUNCH) do |nxt, era|
          -> x { nxt.call(era.call(x)) }
        end
      end
  end


  class Timemachine

    def initialize universe
      @universe = universe
    end

    def back_to at
      @universe.back_to(at)
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

anUniverse = Universe.new([ -> x { p x + 1 },
                            -> y { p y + 2 },
                            -> z { p z + 3 }
                          ])
anUniverse.value(0)
# 1
# 3
# 6

timemachine = Timemachine.new(anUniverse)
timemachine.back_to(1).value(0)
# 2
# 5

puts blackhole.x.y.z
puts Quasar.blackhole.x.y.z
