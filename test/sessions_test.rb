# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'browserstack/automate/sessions'
require 'minitest/reporters'
require 'yaml'
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

require 'minitest/autorun'
# require 'webmock/minitest'
# require 'vcr'

# VCR.configure do |c|
#  c.cassette_library_dir = 'test/fixtures'
#  c.hook_into :webmock
# end
#

#
# puts "Session : Missing the mandatory build name. This should raise an ArgumentError"
# a_sessions = Browserstack::Automate::Sessions.new
# puts "a_sessions="
# pp a_sessions
# print "\n\n"

# puts "Session : build name that does not exist"
# a_sessions = Browserstack::Automate::Sessions.new(build_name: 'This_DOES_NOT_EXIST')
# puts "a_sessions="
# pp a_sessions
# print "\n\n"

# puts "This should return the sessions for build name: browserstack_login_desktop-112"
# a_sessions = Browserstack::Automate::Sessions.new('browserstack_login_desktop-112')
# puts "a_sessions="
# pp a_sessions
# print "\n\n"
#

puts 'Session: Test get_session_info_by_id(it should return a json with all session info)'
session_id_info = Browserstack::Automate::Sessions.new
# pp session_id_info.to_yaml
result = session_id_info.get_session_info_by_id('3b3ac82334f5450d04eb72dd0e4ee602087efc36')
# pp "yaml=", result.to_yaml
pp 'result=', result
pp 'status=', result.status
pp 'hashed_id=', result.hashed_id
pp 'build_name=', result.build_name
pp 'project_name', result.project_name
# pp "status=", result.inspect
print "\n\n"

puts 'Session: Test get_sessions_by_build_name(single session should be returned)'
get_sessions_by_build_name = Browserstack::Automate::Sessions.new.get_sessions_by_build_name('MB184-TChia.local_2019-07-12_15-52-03-03')
puts 'get_sessions_by_build_name=', get_sessions_by_build_name
print "\n\n"

puts 'Session: Test get_sessions_by_build_name(multiple sessions should be returned'
get_sessions_by_build_name = Browserstack::Automate::Sessions.new.get_sessions_by_build_name('browserstack_login_desktop-112')
puts 'get_sessions_by_build_name=', get_sessions_by_build_name
print "\n\n"

# This will cause an exception so uncomment to run and then comment it to test  the rest
# puts "Session: Test get_sessions_by_build_name(invalid build name). Should get an runtime exception"
# get_sessions_by_build_name=Browserstack::Automate::Sessions.new.get_sessions_by_build_name('invalid_build_name')
# puts "get_sessions_by_build_name=", get_sessions_by_build_name
# print "\n\n"

puts 'Session: Update test result passed'
update_result = Browserstack::Automate::Sessions.new.update_test_result(session_id: '2a94ee7370d9a0f1583097823b99540769298b95',
                                                                        test_result_status: 'failed',
                                                                        reason: 'failed reason')
# update_result=Browserstack::Automate::Sessions.new.update_test_result( session_id: '2a94ee7370d9a0f1583097823b99540769298b95',
#                                                                        test_result_status: 'passed',
#                                                                        reason: 'passed reason')
puts 'update_result=', update_result
print "\n\n"

# puts "Session: Update test result failed"
#   print "\n\n"

# puts "This should return one desktop session"
# desktop_sessions = Browserstack::Automate::Session.new(build_name: 'MB184-TChia.local_2019-07-10_15-38-25-25')
# desktop_sessions = Browserstack::Automate::Sessions.new('browserstack_login_desktop-112')
# puts "desktop_sessions="
# pp desktop_sessions
# pp desktop_session.name
# pp desktop_session.duration
# puts "desktop session id=6067a0c82671094ce1ea8ba4e6c1f451722daca0"
# puts "This is the same as https://api.browserstack.com/automate/sessions/6067a0c82671094ce1ea8ba4e6c1f451722daca0.json"

# puts "Testing desktop_session.find_session_id_desktop"
# desktop_session_id=desktop_session.find_session_id_desktop(project_name:'spike',
#                                                            build_name: 'MB184-TChia.local_2019-07-10_15-38-25-25',
#                                                           session_name: 'login_via_username_password_spec',
#                                                           os: 'OS X',
#                                                            os_version: 'Mojave',
#                                                            browser: 'chrome',
#                                                            browser_version: '69.0'
#                                                          )
# puts "desktop_session_id=#{desktop_session_id}"
print "\n\n"

# print "\n\n"
# puts "This should return one mobile session"
# mobile_session = Browserstack::Automate::Session.new('b87221e7c87b29cb0b121b5f97b321a01d4ca20e')
# pp mobile_session
# print "\n\n"

# puts "Testing mobile_session.find_session_id_mobile"
# mobile_session_id=mobile_session.find_session_id_mobile(project_name:'spike',
#                                                         build_name: 'browserstack_login_mobile-20',
#                                                        session_name: 'login_via_username_password_spec',
#                                                        os: 'ios',
#                                                        os_version: '12.1',
#                                                         device: 'iPhone XS'
#                                                       )
# puts "mobile_session_id=#{mobile_session_id}"
