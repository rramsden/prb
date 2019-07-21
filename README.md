# Prb

`prb` is a light-weight timer service written in Ruby for the pomodoro
technique.

## Installation

Install the gem

    $ gem install prb

## Usage

```
prb v0.1.0 - Pomodoro timer service

Usage:
  prb [COMMAND] [SUB_COMMAND]

Options:
  -d, --daemonize    Start the service in the background

Commands:
  start      Start pomodoro service
  stop       Stop pomodoro service
  status     Print status of pomodoro service
  skip       Skip the current timer
  reset      Reset the current timer
  pause      Pause the current timer
  -v, --version      Print version and exit
  -h, --help         Show this message
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rramsden/potime.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
