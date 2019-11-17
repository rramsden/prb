module Prb
  class Opts
    attr_reader :pomodoros, :timer, :port

    def initialize(opts)
      @pomodoros = opts[:pomodoros].to_i
      @timer = opts[:timer].to_i
      @daemonize = opts[:daemonize]
      @port = (opts[:port] || 3838).to_i
    end

    def daemonize?
      !!@daemonize
    end
  end
end
