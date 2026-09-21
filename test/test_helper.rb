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

# browserstatck_plan = Browserstack::Automate::Api::Plan.get_plan
# browserstatck_plan = Browserstack::Automate::Api::Plan.new

# plan = Browserstack::Automate::Api::Plan::Client.new
plan = Browserstack::Automate::Plan.new

# pp plan
print plan

print "\n\n", plan.inspect
# print "\nautomate_plan: ", plan.automate_plan
# print "\nparallel_sessions_running:", plan.parallel_sessions_running
# print "\nteam_parallel_sessions_max_allowed", plan.team_parallel_sessions_max_allowed
# print "\nparallel_sessions_max_allowed", plan.parallel_sessions_max_allowed
# print "\nparallel_sessions_max_allowed: ", plan.queued_sessions
# print "\nqueued_sessions_max_allowed: ", plan.queued_sessions_max_allowed

print "\n\n"

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
