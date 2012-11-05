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


  class Qubit

    def initialize possibilities
      @possibilities = possibilities
    end

    def bind &fn
      Qubit.new @possibilities.map &fn
    end

    def == other
      return false unless other.is_a? Qubit
      return @possibilities == other.instance_variable_get(:@possibilities)
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

if __FILE__ == $0

  # example
  require 'test/unit'
  class TestQuasar < Test::Unit::TestCase

    include Quasar

    def test_qubit
      qubit = Qubit.new([1,2,3,4,5])
      result = qubit.bind { |possibility| possibility + 1 }
      assert_equal(Qubit.new([2,3,4,5,6]), result)
    end

    def test_universe
      anUniverse = Universe.new([ -> x { x + "b" },
                                  -> y { y + "c" },
                                  -> z { z + "d" }
                                ])
      result = anUniverse.value("a")
      assert_equal("abcd", result)
    end

    def test_timemachine
      anUniverse = Universe.new([ -> x { x + "b" },
                                  -> y { y + "c" },
                                  -> z { z + "d" }
                                ])
      timemachine = Timemachine.new(anUniverse)
      result = timemachine.back_to(1).value("a")
      assert_equal("acd", result)
    end

    def test_blackhole
      assert_equal(blackhole, blackhole.x.y.z)
    end
  end
end
