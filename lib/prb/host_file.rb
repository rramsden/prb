module Prb
  # Manipulates /etc/hosts file on unix based systems
  class HostFile
    def self.remove_section(tagname)
      contents = ''

      File.open('/etc/hosts', 'r') do |file|
        contents = file.read
        contents = contents.gsub(/\n# {{{ #{tagname}.*}}}/m, '')
      end

      make_tmp_file do |file|
        file.write(contents)
        file.close

        system("sudo cp #{file.path} /etc/hosts")
      end
    end

    def self.add_section(tagname, domains)
      remove_section(tagname) # prevent double append

      contents = "\n# {{{ #{tagname}\n"
      contents << domains.map{ |d| "127.0.0.1 #{d}" }.join("\n")
      contents << "\n# }}}"

      make_tmp_file do |file|
        file.write(contents)
        file.close

        system("cat #{file.path} | sudo tee -a /etc/hosts > /dev/null")
      end
    end

    def self.make_tmp_file
      Dir.mktmpdir do |tmpdir|
        filepath = File.join(tmpdir, 'tmp')

        File.open(filepath, 'w') do |file|
          yield file
        end
      end
    end
  end
end
