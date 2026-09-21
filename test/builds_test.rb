# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'browserstack/automate/builds'
require 'minitest/reporters'
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

require 'minitest/autorun'
# require 'webmock/minitest'
# require 'vcr'

# VCR.configure do |c|
#  c.cassette_library_dir = 'test/fixtures'
#  c.hook_into :webmock
# end

# builds = Browserstack::Automate::Builds.new
#
# pp builds
# print builds
#
# puts "\n\n", builds
#
# print "\n\n"
#
# puts "build_name=browserstack_login_desktop-112"
# id=builds.get_build_id_by_name('browserstack_login_desktop-112')
# puts "this should be 885e4d1b2b3e71d009c9475c688a740105a79277"
# puts " id=#{id}"
#
# print "\n\n"
# puts "build_name=invalid build"
# id=builds.get_build_id_by_name('invalid build')
# puts "this should be empty"
# puts " id=#{id}"
# print "\n\n"
#

puts 'Testing with valid build name for get_build_by_name method'
builds = Browserstack::Automate::Builds.new
pp builds
puts 'Testing build_name=MB184-TChia.local_2019-07-12_15-52-03-03'
local_build = builds.get_build_by_name('MB184-TChia.local_2019-07-12_15-52-03-03')
pp local_build
puts "This should return a single local build session #{local_build}"
print "\n\n"
# pp local_build['name']
local_build.each do |key, value|
  puts "#{key}: #{value}\n"
end

puts 'Testing with invalid build name for get_build_by_name method'
invalid_builds = Browserstack::Automate::Builds.new
invalid_builds = invalid_builds.get_build_by_name('this_does_not_exist')
pp invalid_builds
print "\n\n"
puts 'Testing valid build name with get_build_sessions_by_name method =MB184-TChia.local_2019-07-12_15-52-03-03'
valid_builds = Browserstack::Automate::Builds.new
valid_build_sessions = valid_builds.get_build_sessions_by_name(build_name: 'MB184-TChia.local_2019-07-12_15-52-03-03')
pp valid_build_sessions
print "\n\n"

puts 'Testing invalid build with get_build_sessions_by_name method'
invalid_builds = Browserstack::Automate::Builds.new
invalid_build_sessions = invalid_builds.get_build_sessions_by_name(build_name: 'this_does_not_exist')
pp invalid_build_sessions
print "\n\n"

# puts "Testing build name=browserstack_login_desktop-112"
# jenkins_build_sessions=builds.get_build_sessions_by_name(build_name: 'browserstack_login_desktop-112')
# jenkins_build_sessions=builds.get_build_sessions_by_name(build_name: 'MB184-TChia_2019-07-24_11-22-52-52')
# puts "This should contains multiple jenkins build sessions"
# pp jenkins_build_sessions
# print "\n\n"
#
# puts "Testing failed builds"
# failed_builds = Browserstack::Automate::Builds.new.get_failed_builds
# puts "This should contains failed build only"
# pp failed_builds
# print "\n\n"
#
# puts "Testing running builds"
# running_builds = Browserstack::Automate::Builds.new.get_running_builds
# puts "This should contains running build only"
# pp running_builds
# print "\n\n"
#
# puts "Testing done builds"
# done_builds = Browserstack::Automate::Builds.new.get_done_builds
# puts "This should contains done build only"
# pp done_builds
# print "\n\n"
#
# puts "Testing timeout builds"
# timeout_builds = Browserstack::Automate::Builds.new.get_timeout_builds
# puts "This should contains timeout build only"
# pp timeout_builds
# print "\n\n"
#
