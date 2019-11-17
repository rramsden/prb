# Prb

Prb is a light-weight HTTP service written in Ruby for controlling a pomodoro
timer.

## Installation

Install the gem

    $ gem install prb

## Usage

The promodoro timer can be started using `prb start -d` where `-d` will
run the process in the background.

```
prb start -d
```

Options can be passed to configure the timer. By default, there are 4 pomodoro's
each taking 25 minutes to complete. You can override this behaviour using the
following command:

```
prb start -d --pomodoros=4 --timer=25
```

After starting the service you can query the timers status over HTTP using
`curl`:

```
curl http://localhost:3838/status

{
    "running" true,
    "completed": 0, # completed pomodoros
    "remaining": 4, # remaining pomodoros
    "time_remaining": 440
}
```

After each pomodoro the timer will stop. The timer can be resumed
and the next pomodoro started by using `prb resume` or by `curl` request:

```
curl http://localhost:3838/resume
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rramsden/potime.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
