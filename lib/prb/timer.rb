module Prb
  class Timer
    def initialize(minutes)
      @paused = false
      set_timer(minutes)
    end

    def set_timer(minutes)
      @_seconds = minutes * 60
      @seconds = @_seconds
    end

    def tick
      sleep 1
      @seconds -= 1 unless @paused or finished?
    end

    def finished?
      @seconds == 0
    end

    def reset
      @seconds = @_seconds
    end

    def pause
      @paused = !@paused
    end

    def paused?
      @paused
    end

    def render
      min = (@seconds / 60) % 60
      sec = (@seconds % 60)

      format("%02d:%02d", min, sec)
    end
  end
end
