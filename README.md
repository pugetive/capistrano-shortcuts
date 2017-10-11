# Capistrano::Shortcuts

This gem simply encapsulate the common custom server tasks I use to manage Rails projects. It assumes a two-tiered development including both staging and production environments.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-shortcuts'
```


And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-shortcuts


And include the tasks via your Capfile:

    require 'capistrano/shortcuts'

## Maintenance Mode

Install the maintenance page and show it instead of executing the web app:

    cap <environment> deploy:web:disable


Resume normal operation:

    cap <environment> deploy:web:enable


## Memcache

Clears all data stored in memcache by restarting the server. This task requires passwordless sudo to be set up on the server.

    cap <environment> memcache:flush

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pugetive/capistrano-shortcuts.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
