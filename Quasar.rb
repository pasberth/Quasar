module Quasar

  extend self

  def blackhole
    @blackhole ||= Blackhole.new
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
end

# example
include Quasar
puts blackhole.x.y.z
puts Quasar.blackhole.x.y.z
