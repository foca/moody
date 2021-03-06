Moody: An implementation of the State Pattern in ruby
=====================================================

This is an object-oriented way to represent Finite State Machines, where an
object can change its behavior at runtime, depending on its internal state.

If you want more information about this pattern, read [the explanation by
SourceMaking](http://sourcemaking.com/design_patterns/state).

For a stupid example of how you would use this, here is a traffic light:

    class Stop < Moody::State
      def color
        "red"
      end

      def next
        sleep 3
        switch_to Go
      end

      def enter
        # turn on camera tu see who crosses on a red light
      end

      def leave
        # turn off camera
      end
    end

    class Go < Moody::State
      def color
        "green"
      end

      def next
        sleep 2
        switch_to Caution
      end
    end

    class Caution < Moody::State
      def color
        "yellow"
      end

      def next
        sleep 1
        switch_to Stop
      end
    end

    class TrafficLight
      extend  Moody::Context

      initial_state Stop
      delegate_to_state :color, :next
    end

    traffic_light - TrafficLight.new

    loop do
      puts traffic_light.color
      traffic_light.next
    end

Callbacks
---------

As you can see from the example above, Moody also provides callbacks when
entering and leaving a state. If your state classes define instance methods
`enter` and `leave`, then they will be called at the appropriate times.

Inspiration
-----------

This is a reimplementation of the State Pattern gem by Daniel Cadenas. Check out
his implementation at [his repository](http://github.com/dcadenas/state_pattern).

Installing
----------

    gem install moody

Contributing
------------

* Send a pull request.
* Small, atomic commits, please.
* Make sure to add tests.
* Bonus points if you add features on topic branches.

License
-------

Copyright Nicolás Sanguinetti <hi@nicolassanguinetti.info>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
