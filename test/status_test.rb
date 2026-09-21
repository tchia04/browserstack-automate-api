# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
# require 'browserstack/automate/api'
require 'browserstack/automate/plan'
require 'browserstack/automate/status'

# require 'plan'
require 'minitest/reporters'
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

require 'minitest/autorun'
# require 'webmock/minitest'
# require 'vcr'

# VCR.configure do |c|
#  c.cassette_library_dir = 'test/fixtures'
#  c.hook_into :webmock
# end

status = Browserstack::Automate::Status.new
# pp status
# print "\nused_time: ", status.used_time
# print "\ntotal_available_time: ", status.total_available_time
# print "\nrunning_sessions: ", status.running_sessions
# print "\nsessions_limit: ", status.sessions_limit
# print "\n\n"
print status

print "\n\n", status.inspect
print "\n\n"

# puts browserstatck_plan.inspect
# puts browserstatck_plan.to_s
