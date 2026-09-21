# Browserstack::Automate::Api

[![Build Status](https://travis-ci.org/tchia04/browserstack-automate-api.svg?branch=master)](https://travis-ci.org/tchia04/browserstack-automate-api)

[![Maintainability](https://api.codeclimate.com/v1/badges/afcdb7ef887f4d898ff1/maintainability)](https://codeclimate.com/github/tchia04/browserstack-automate-api/maintainability)

This gem wraps the Browserstack Automate API at https://api.browserstack.com as a ruby gem

Currently it only support mostly get method and a PUT method to update the test result

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'browserstack-automate-api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install browserstack-automate-api

## Usage

To require all the libraries,  Add this to the top of your .rb file
```
require 'browserstack_automate_api'
```

To require an individual library, add one or more of the following to the top of your .rb file
```
require 'browserstack/automate/api'
require 'browserstack/automate/plan'
require 'browserstack/automate/projects'
require 'browserstack/automate/status'
require 'browserstack/automate/builds'
require 'browserstack/automate/sessions'
```

After the libraries have been loaded, you can initialize with the following

```
Browserstack::Automate::RubyApi::VERSION
Browserstack::Automate::Status.new
Browserstack::Automate::Plan.new
Browserstack::Automate::Projects.new
Browserstack::Automate::Builds.new
Browserstack::Automate::Sessions.new
```

### Plan
```

plan = Browserstack::Automate::Plan.new
pp plan
print "\nautomate_plan: ", plan.automate_plan
print "\nparallel_sessions_running:", plan.parallel_sessions_running
print "\nteam_parallel_sessions_max_allowed", plan.team_parallel_sessions_max_allowed
print "\nparallel_sessions_max_allowed", plan.parallel_sessions_max_allowed
print "\nparallel_sessions_max_allowed: ", plan.queued_sessions
print "\nqueued_sessions_max_allowed: ", plan.queued_sessions_max_allowed
```

### Projects
```
projects= Browserstack::Automate::Project.new
spike_project=projects.get_project_by_name(project_name: 'spike')
pp spike_project
pp spike_project['id']
pp spike_project['name']
pp spike_project['group_id']
pp spike_project['user_id']
pp spike_project['created_at']
pp spike_project['updated_at']
```

### Status
```
status = Browserstack::Automate::Status.new
print status
```

### Builds
```
builds = Browserstack::Automate::Builds.new
pp builds
```

### Sessions
```
sessions==Browserstack::Automate::Sessions.new.get_sessions_by_build_name('browserstack_login_desktop-112')
puts "get_sessions_by_build_name=", sessions
print "\n\n"

puts "Session: Update test result passed"
update_result=Browserstack::Automate::Sessions.new.update_test_result(session_id: '2a94ee7370d9a0f1583097823b99540769298b95', test_result_status: 'passed', reason: 'passed reason')
puts "update_result=",update_result
print "\n\n"

puts "Session: Update test result failed"
update_result=Browserstack::Automate::Sessions.new.update_test_result(session_id: '2a94ee7370d9a0f1583097823b99540769298b95', test_result_status: 'failed', reason: 'failed reason')
puts "update_result=",update_result
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/browserstack-automate-api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Browserstack::Automate::Api project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/browserstack-automate-api/blob/master/CODE_OF_CONDUCT.md).
