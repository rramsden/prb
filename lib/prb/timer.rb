module Prb
  class Timer
    attr_reader :pomodoros, :seconds, :paused, :completed

    WORKING = 1
    PAUSED = 2

    def initialize(opts)
      @opts = opts

      @paused = false
      @pomodoros = opts.pomodoros

      # set pomodoro timer
      set_timer(@opts.timer)
    end

    def tick
      return if completed? or paused? 

      if @seconds == 0
        if @paused == false
          @pomodoros -= 1
          @paused = true
        end
      else
        @seconds -= 1
      end
    end

    def resume
      @paused = false
      set_timer(@opts.timer)
    end

    def reset
      @paused = false
      @pomodoros = @opts.pomodoros
      set_timer(@opts.timer)
    end

    def paused?
      @paused
    end

    private

    def set_timer(minutes)
      @_seconds = minutes * 60
      @seconds = @_seconds
    end

    def completed?
      @pomodoros == 0
    end
  end
end
