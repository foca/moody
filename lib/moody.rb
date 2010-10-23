module Moody
  module Context
    def self.extended(base)
      base.class_eval do
        attr_accessor :state
      end
    end

    def initial_state(state)
      module_eval <<-RUBY
        def state
          @state ||= #{state}.new(self)
        end
      RUBY
    end

    def delegate_to_state(*methods)
      method_definitions = methods.inject("") do |code, method|
        code + <<-RUBY
          def #{method}(*args, &block)
            state.#{method}(*args, &block)
          end
        RUBY
      end

      module_eval(method_definitions)
    end
  end

  class State
    attr_reader :context

    def initialize(context)
      @context = context
    end

    def switch_to(next_state)
      context.state = next_state.new(context)
    end
  end
end
