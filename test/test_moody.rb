require "test/unit"
require "moody"
require "ostruct"

class Stop < Moody::State
  def color
    "red"
  end

  def next
    switch_to Go
  end
end

class Go < Moody::State
  def color
    "green"
  end

  def next
    switch_to Caution
  end
end

class Caution < Moody::State
  def color
    "yellow"
  end

  def next
    switch_to Stop
  end
end

class TrafficLight
  extend  Moody::Context

  initial_state Stop
  delegate_to_state :color, :next
end

class TestMoodyByExample < Test::Unit::TestCase
  def setup
    @context = TrafficLight.new
  end

  def test_initial_state
    assert @context.state.is_a?(Stop)
  end

  def test_switch_state
    @context.next
    assert @context.state.is_a?(Go)
    @context.next
    assert @context.state.is_a?(Caution)
    @context.next
    assert @context.state.is_a?(Stop)
  end

  def test_delegate_properties
    @context.next
    assert_equal "green",  @context.color
    @context.next
    assert_equal "yellow", @context.color
    @context.next
    assert_equal "red",    @context.color
  end
end
