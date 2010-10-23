require "test/unit"
require "moody"

class TestMoodyByExample < Test::Unit::TestCase
  class SiegeMode < Moody::State
    def strength
      50
    end

    def siege_mode!
    end

    def tank_mode!
      switch_to TankMode
    end

    def cheat!
      switch_to CheatMode
    end
  end

  class TankMode < Moody::State
    def strength
      20
    end

    def siege_mode!
      switch_to SiegeMode
    end

    def tank_mode!
    end

    def cheat!
      switch_to CheatMode
    end
  end

  class CheatMode < Moody::State
    def strength
      100
    end

    def siege_mode!
      switch_to SiegeMode
    end

    def tank_mode!
      switch_to TankMode
    end

    def cheat!
    end

    def enter
      $callbacks << "You're a cheat!"
    end

    def leave
      $callbacks << "Honesty is valuable!"
    end
  end

  class SiegeTank
    extend Moody::Context

    initial_state TankMode
    delegate_to_state :strength, :tank_mode!, :siege_mode!, :cheat!

    def attack(target)
      "dealt #{strength} to #{target}"
    end
  end

  class EmptyContext
    class A < Moody::State; end
    class B < Moody::State; end

    extend Moody::Context

    initial_state A
  end

  def setup
    $callbacks = []
    @context_class = Class.new(SiegeTank)
  end

  def test_initial_state
    @context_class.initial_state SiegeMode

    test_context = @context_class.new
    assert test_context.state.is_a?(SiegeMode)
  end

  def test_switch_state
    test_context = @context_class.new
    test_context.siege_mode!
    assert test_context.state.is_a?(SiegeMode)
    test_context.tank_mode!
    assert test_context.state.is_a?(TankMode)
  end

  def test_switch_from_context
    test_context = EmptyContext.new
    test_context.switch_to EmptyContext::B
    assert test_context.state.is_a?(EmptyContext::B)
  end

  def test_delegates_methods
    test_context = @context_class.new
    test_context.siege_mode!
    assert_equal "dealt 50 to target", test_context.attack("target")
    test_context.tank_mode!
    assert_equal "dealt 20 to target", test_context.attack("target")
  end

  def test_provides_callbacks
    test_context = @context_class.new
    test_context.cheat!
    assert_equal "You're a cheat!", $callbacks.pop
    test_context.siege_mode!
    assert_equal "Honesty is valuable!", $callbacks.pop
  end
end
