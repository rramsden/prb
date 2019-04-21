module Prb
  class CLI
    attr_reader :minutes, :seconds

    WORK_MINUTES = 25
    BREAK_MINUTES = 5

    def initialize
      @is_working = true
      @pause = false
      set_timer(WORK_MINUTES)
    end

    def set_timer(minutes)
      @minutes = minutes
      @seconds = minutes * 60
    end

    def render
      print "\e[H\e[2J" # clear screen
      min = (@seconds / 60) % 60
      sec = (@seconds % 60)

      if @is_working
        puts format("[WORKING] %02d:%02d".red, min, sec)
      else
        puts format("[BREAK] %02d:%02d".green, min, sec)
      end
    end

    def start
      Thread.new do
        loop do
          sleep 1
          next if @pause

          system("stty raw opost -echo") # something we need

          if @seconds == 0
            @is_working = !@is_working
            @is_wokring ? set_timer(WORK_MINUTES) : set_timer(BREAK_MINUTES)
          end

          @minutes = (@seconds / 60) % 60

          render

          @seconds = @seconds - 1
        end
      end

      loop do
        ch = STDIN.getch
        case ch
        when "r"
          @seconds = @minutes * 60
          render
        when "p"
          @pause = !@pause
        when "q"
          exit
        end
      end
    end
  end
end
