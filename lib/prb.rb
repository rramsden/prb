require "colorize"
require_relative "prb/version"
require_relative "prb/host_file"
require_relative "prb/config"
require_relative "prb/firewall"
require_relative "prb/timer"
require_relative "prb/timer_control"
require_relative "prb/cli"

module Prb
  def self.config
    @@config ||= Prb::Config.new
  end
end
