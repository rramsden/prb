module Prb
  class CommandRunner
    def initialize(opts)
      @opts = Opts.new(opts)
    end

    def start
      if running?(@opts.port)
        puts "A prb server is already running."
        exit(1)
      end

      Process.daemon() if @opts.daemonize?

      app = Prb::Server.new(@opts)
      Rack::Server.start(
        app: app,
        Port: @opts.port
      )
    end

    def resume
      send_request('resume')
    end

    def stop
      send_request('stop')
    end

    private

    def send_request(endpoint)
      uri = URI.parse("http://0.0.0.0:#{@opts.port}/#{endpoint}")
      Net::HTTP.get_response(uri)
    rescue
      nil
    end

    def running?(port)
      Timeout::timeout(1) do
        begin
          s = TCPSocket.new('0.0.0.0', port)
          s.close
          return true
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          return false
        end
      end
    end
  end
end
