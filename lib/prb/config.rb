require 'yaml'

module Prb
  class Config
    def initialize
      begin
        @config = YAML.load_file( File.expand_path('~/.prbrc') )
      rescue Errno::ENOENT
        puts "Configuration file does not exist ~/.prbrc"
      end
    end

    # Domains to block with Firewall
    def domains
      @config['blacklist']
    end
  end
end
