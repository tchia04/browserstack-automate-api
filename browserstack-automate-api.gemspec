# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'browserstack/automate/api/version'

Gem::Specification.new do |spec|
  spec.name          = 'browserstack-automate-api'
  spec.version       = Browserstack::Automate::Api::VERSION
  spec.authors       = ['Tony Chia']
  spec.email         = ['tchia04@gmail.com']

  spec.summary       = ' Access Browserstack Automate API '
  spec.description   = ' RubyGem for https://www.browserstack.com/automate/rest-api '
  spec.homepage      = 'https://github.com/tchia04/browserstack-automate-api'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/tchia04/browserstack-automate-api'
    spec.metadata['changelog_uri'] = 'https://github.com/tchia04/browserstack-atuomate-api/CHANGELOG.md'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17.2'
  spec.add_development_dependency 'rake', '~> 12.3.2'
  spec.add_development_dependency 'rspec', '~> 3.8.0'
  spec.add_development_dependency 'rubocop', '~> 0.67.2'
end
