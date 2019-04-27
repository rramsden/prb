module Prb
  class CLI
    def initialize
      @controller = TimerControl.new
    end

    def start
      @controller.start

      # render loop
      Thread.new do
        loop do
          sleep 0.1
          render
        end
      end

      # input loop
      loop do
        ch = STDIN.getch
        case ch
        when "s" # skip
          @controller.toggle
        when "r" # reset
          @controller.reset
        when "p" # pause
          @controller.pause
        when "q"
          exit
        end
      end
    end

    private

    def render
      # prevent text from being indented in terminal
      system("stty raw opost -echo")

      print "\e[H\e[2J" # clear screen

      if @controller.is_working?
        puts "[WORKING] #{@controller.timer.render}".red
      else
        puts "[BREAK] #{@controller.timer.render}".green
      end

      puts <<~MSG
      s) Skip
      #{@controller.paused? ? 'p) Paused'.yellow : 'p) Pause'}
      q) Quit

      MSG
    end
  end
end
