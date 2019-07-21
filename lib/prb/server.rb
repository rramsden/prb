require 'socket'
require 'timeout'

module Prb
  PRB_PORT = 3838

  class Server
    def initialize
      @controller = TimerControl.new
    end

    def start
      @controller.start

      server = TCPServer.open('127.0.0.1', PRB_PORT)
      puts "Server listening on #{PRB_PORT}"

      while true
        Thread.start(server.accept) do |socket|
          while cmd = socket.gets.chomp
            puts "RECV: #{cmd}"

            output = "OK"
            case cmd
            when 'STATUS'
              output = status_line
            when 'SKIP'
              @controller.toggle
            when 'RESET'
              @controller.reset
            when 'PAUSE'
              @controller.pause
            when 'QUIT'
              socket.puts "OK"
              exit(0)
            else
              puts "ERR: #{cmd} not a command"
              output = "ERR: #{cmd} not a command"
            end

            socket.puts output
          end

          socket.close
        end
      end

      server.close
    end

    def self.running?
      Timeout::timeout(1) do
        begin
          s = TCPSocket.new('127.0.0.1', PRB_PORT)
          s.close
          return true
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          return false
        end
      end
    end

    private

    def status_line
      status = ""
      status << "W" if @controller.is_working?
      status << "B" if !@controller.is_working?
      status << "P" if @controller.paused?
      status << ","
      status << @controller.timer.render
    end
  end
end
