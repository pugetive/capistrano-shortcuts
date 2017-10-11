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

## Config Files

Push all config files listed in the :linked_files variable to the specified environment:

    cap <environment> config:push


Pull all config files listed in the :linked_files variable down from the specified environment:

    cap <environment> config:pull


Symlink environment-specific .htaccess and robots.txt files to their expected location:

    cap <environment> config:symlink


Push the config files and restart the server to pick up changes immediately:

    cap <environment> config:reconfig


## Maintenance Mode

Install the maintenance page and show it instead of executing the web app:

    cap <environment> deploy:web:disable


Resume normal operation:

    cap <environment> deploy:web:enable


## Apache

Reload apache:

    cap <environment> apache:reload

Restart apache:

    cap <environment> apache:restart

Copy all domain-related config files from the rails repo "config/apache" directory into the sites-available directory for apache to pick up, and re-enable the website specified in <code>&lt;domain-name.conf&gt;</code> as well as <code>assets.&lt;domain-name&gt;.conf</code>:

    cap <environment> apache:install

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
