# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

# This doesn't work yet
# task default: :test
task default: %i[rubocop rspec]

require 'rubocop/rake_task'

RuboCop::RakeTask.new(:rubocop) do |t|
  t.options = ['--display-cop-names']
  t.options << ['--display-style-guide']
end

# We recommend you wrap this in a rescue clause so that you can
# use your Rakefile in an environment where RSpec is unavailable
# (for example on a production server)
begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:rspec)
rescue LoadError
end
