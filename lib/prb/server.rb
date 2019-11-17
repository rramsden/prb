require 'timeout'
require 'sinatra/base'

module Prb
  class Server < Sinatra::Base
    def initialize(opts)
      puts <<~MSG
      Starting pomodoro service...

      Number of pomodoros: #{opts.pomodoros} pomodoro(s)
      Pomodoro timer:      #{opts.timer} minute(s)

      MSG

      @controller = TimerControl.new(opts)
      @controller.start

      super
    end

    get '/status' do
      content_type :json
      @controller.render_status
    end

    get '/reset' do
      @controller.reset
      status 200
    end

    get '/resume' do
      @controller.resume
      status 200
    end

    get '/stop' do
      Process.kill("INT", Process.pid)
    end
  end
end
