module Prb
  class CLI
    def initialize
      @controller = TimerControl.new
    end

    def start
      @controller.start

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
  end
end
