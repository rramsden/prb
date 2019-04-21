module Prb
  class CLI
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

          toggle_timer if @timer.finished?

          render
        end
      end

      loop do
        ch = STDIN.getch
        case ch
        when "s" # skip
          toggle_timer
        when "r" # reset
          @timer.reset
          render
        when "p" # pause
          @timer.pause
          sleep 1
        when "q"
          exit
        end
      end
    end

    private

    def toggle_timer
      @is_working = !@is_working
      @timer.set_timer(@is_working ?
                      WORK_MINUTES : BREAK_MINUTES)
      @timer.pause unless @timer.paused?
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
    end

    def clear_screen
      print "\e[H\e[2J" # clear screen
    end
  end
end
