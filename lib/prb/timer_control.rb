module Prb
  class TimerControl
    attr_reader :timer

    def initialize(opts)
      @opts = opts
      @timer = Timer.new(@opts)
    end

    def start
      Thread.new do
        loop do
          sleep 1
          @timer.tick
        end
      end
    end

    def render_status
      {
        running: !@timer.paused?,
        completed: @opts.pomodoros - @timer.pomodoros,
        remaining: @timer.pomodoros,
        time_remaining: @timer.seconds,
      }.to_json
    end

    def reset
      @timer.reset
    end

    def resume
      @timer.resume
    end
  end
end
