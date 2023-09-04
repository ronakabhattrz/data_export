# frozen_string_literal: true

require_relative "lib/export_data/version"

Gem::Specification.new do |spec|
  spec.name = "export_data"
  spec.version = DataExport::VERSION
  spec.authors = ["RONAK BHATT"]
  spec.email = ["ronakabhattrz@gmail.com"]

  spec.summary = "A Data Import/Export Gem for Ruby on Rails"
  spec.description = "Simplify data import and export tasks in Rails applications."
  spec.homepage = "https://github.com/ronakabhattrz/export_data"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"
  
  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ronakabhattrz/export_data"
  spec.metadata["changelog_uri"] = "https://github.com/ronakabhattrz/export_data/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = %w[.rspec .rubocop.yml CHANGELOG.md CODE_OF_CONDUCT.md LICENSE.txt README.md Rakefile export_data.gemspec lib/export_data.rb lib/export_data/version.rb sig/export_data.rbs]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
