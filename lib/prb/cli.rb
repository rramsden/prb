module Prb
  class CLI
    def initialize
      @controller = TimerControl.new
      @render = true
    end

    def start
      @controller.start

      # render loop
      Thread.new do
        loop do
          sleep 0.1
          render if @render
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
        when "f" # activate firewall
          stop_rendering do
            @controller.toggle_firewall
          end
        when "q"
          exit
        end
      end
    end

    private

    # ask for sudo access
    def stop_rendering
      @render = false
      yield
      @render = true
    end

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
      #{@controller.paused? ? 'p) Pause'.yellow : 'p) Pause'}
      #{@controller.firewall.enabled? ? 'f) Firewall'.yellow : 'f) Firewall'}
      q) Quit

      MSG
    end
  end
end
