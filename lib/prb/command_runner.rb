module Prb
  class CommandRunner
    def initialize(opts)
      @opts = opts
    end

    def start
      if Prb::Server.running?
        puts "A prb server is already running."
        exit(1)
      end

      Process.daemon() if @opts[:daemonize]

      Prb::Server.new.start
    end

    def status
      response = send_command('STATUS')
      puts response
    end

    def skip
      send_command('SKIP')
    end

    def pause
      send_command('PAUSE')
    end

    def reset
      send_command('RESET')
    end

    def stop
      send_command('QUIT')
    end

    private

    def send_command(cmd)
      Timeout::timeout(1) do
        begin
          s = TCPSocket.new('127.0.0.1', PRB_PORT)
          s.puts(cmd)
          response = s.gets.chomp
          s.close
          return response
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          puts "A prb server is not running"
          exit(1)
        end
      end
    end
  end

end
