require 'tmpdir'

module Prb
  # Changes /etc/hosts to block network requests to
  # Facebook, Slack, etc.
  class Firewall
    # Theses services are distracting!
    DOMAINS = %w[
      facebook.com
      mail.google.com
      slack.com
    ]

    def initialize
      @activated = false
    end

    def enabled?
      @activated
    end

    def activate!
      append_etc_hosts!
      @activated = true
    end

    def deactivate!
      undo_etc_hosts!
      @activated = false
    end

    def make_tmp_file
      Dir.mktmpdir do |tmpdir|
        filepath = File.join(tmpdir, 'tmp')

        File.open(filepath, 'w') do |file|
          yield file
        end
      end
    end

    def undo_etc_hosts!
      contents = ''

      File.open('/etc/hosts', 'r') do |file|
        contents = file.read
        contents = contents.gsub(/\n# BEGINPRB.*ENDPRB/m, '')
      end

      make_tmp_file do |file|
        file.write(contents)
        file.close

        system("sudo cp #{file.path} /etc/hosts")
      end
    end

    def append_etc_hosts!
      undo_etc_hosts!

      contents = "\n# BEGINPRB\n"
      contents << DOMAINS.map{ |d| "127.0.0.1 #{d}" }.join("\n")
      contents << "\n# ENDPRB"

      make_tmp_file do |file|
        file.write(contents)
        file.close

        system("cat #{file.path} | sudo tee -a /etc/hosts > /dev/null")
      end
    end
  end
end
