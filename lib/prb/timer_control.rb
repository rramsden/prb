module Prb
  class TimerControl
    WORK_MINUTES = 25
    BREAK_MINUTES = 5

    attr_reader :timer, :firewall

    def initialize
      @timer = Timer.new(WORK_MINUTES)
      @firewall = Firewall.new
      @is_working = true
    end

    def start
      Thread.new do
        loop do
          @timer.tick
          toggle if @timer.finished?
        end
      end
    end

    def reset
      @timer.reset
    end

    def pause
      @timer.pause
    end

    def paused?
      @timer.paused?
    end

    def is_working?
      @is_working
    end

    def toggle_firewall
      if @firewall.enabled?
        @firewall.deactivate!
      else
        @firewall.activate!
      end
    end

    def toggle
      @is_working = !@is_working
      @timer.set_timer(@is_working ?
                      WORK_MINUTES : BREAK_MINUTES)
      @timer.pause unless @timer.paused?
    end
  end
end
