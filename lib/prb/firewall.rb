require 'tmpdir'

module Prb
  # Changes /etc/hosts to block network requests to
  # Facebook, Slack, etc.
  class Firewall
    def initialize
      @activated = false
    end

    def enabled?
      @activated
    end

    def activate!
      Prb::HostFile.add_section('PRB', Prb.config.domains)
      @activated = true
    end

    def deactivate!
      Prb::HostFile.remove_section('PRB')
      @activated = false
    end
  end
end
