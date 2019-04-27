module Prb
  class TimerControl
    WORK_MINUTES = 25
    BREAK_MINUTES = 5

    def initialize
      @timer = Timer.new(WORK_MINUTES)
      @is_working = true
    end

    def start
      Thread.new do
        loop do
          @timer.tick

          toggle if @timer.finished?

          render
        end
      end
    end

    def reset
      @timer.reset
    end

    def pause
      @timer.pause
    end

    def clear_screen
      print "\e[H\e[2J" # clear screen
    end

    def render
      # prevent text from being indented in terminal
      system("stty raw opost -echo")

      clear_screen

      if @is_working
        puts "[WORKING] #{@timer.render}".red
      else
        puts "[BREAK] #{@timer.render}".green
      end

      puts <<~MSG
      s) Skip
      p) Pause timer
      q) Quit

      MSG
    end

    def toggle
      @is_working = !@is_working
      @timer.set_timer(@is_working ?
                      WORK_MINUTES : BREAK_MINUTES)
      @timer.pause unless @timer.paused?
    end
  end
end
