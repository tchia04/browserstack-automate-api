# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'browserstack/automate/projects'
require 'minitest/reporters'
Minitest::Reporters.use! [Minitest::Reporters::SpecReporter.new]

require 'minitest/autorun'
# require 'webmock/minitest'
# require 'vcr'

# VCR.configure do |c|
#  c.cassette_library_dir = 'test/fixtures'
#  c.hook_into :webmock
# end

projects = Browserstack::Automate::Projects.new

# pp plan
# print projects
pp projects

# puts "\n\n", projects

print "\n\n"

puts "Testing get_project_id_by_name('spike')"
id = projects.get_project_id_by_name(project_name: 'spike')
puts "id=#{id}"

id = projects.get_project_id_by_name(project_name: 'invalid Project')
puts "this should be empty id=#{id}"

print "\n\n"
puts "Testing get_project_by_name('spike')"
spike_project = projects.get_project_by_name(project_name: 'spike')
puts "this should a project #{spike_project}"

print "\n\n"
puts "Testing get_project_by_name('invalid project name')"
invalid_project = projects.get_project_by_name(project_name: 'invalid project name')
puts "this should an empty project #{invalid_project}"

print "\n\n"
puts 'Testing spike_project members'
pp spike_project
pp spike_project['id']
pp spike_project['name']
pp spike_project['group_id']
pp spike_project['user_id']
pp spike_project['created_at']
pp spike_project['updated_at']

print "\n\n"
puts 'Testing spike_project members using .each'
spike_project.each do |key, value|
  puts "#{key}: #{value}\n"
end
print "\n\n"

puts "Testing get_project_by_name('BrowserStack') search by hash"
bs_project = projects.get_project_by_name(project_name: 'BrowserStack')
puts "this should a project #{bs_project}"
print "\n\n"

puts 'Testing project name: Untitled Project. Make API call(/automate/projects/<project-id>.json)'
spike_project_builds = projects.get_builds_by_name(project_name: 'Untitled Project')
puts 'This should contains multiple project builds'
pp spike_project_builds
print "\n\n"
