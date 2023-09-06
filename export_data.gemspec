# frozen_string_literal: true

require_relative "lib/export_data/version"

Gem::Specification.new do |spec|
  spec.name = "export_data"
  spec.version = DataExport::VERSION
  spec.authors = ["RONAK BHATT"]
  spec.email = ["ronakabhattrz@gmail.com"]

  spec.summary = "A Data Import/Export Gem for Ruby on Rails"
  spec.description = "Simplify data import and export tasks in Rails applications."
  spec.homepage = "https://rubygems.org/gems/export_data"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"
  
  spec.metadata["allowed_push_host"] = "https://rubygems.org"
  
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ronakabhattrz/export_data"
  spec.metadata["changelog_uri"] = "https://github.com/ronakabhattrz/export_data/blob/main/CHANGELOG.md"
  spec.metadata["documentation_uri"] = "https://www.rubydoc.info/gems/export_data/#{DataExport::VERSION}"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = %w[.rspec .rubocop.yml CHANGELOG.md CODE_OF_CONDUCT.md LICENSE.txt README.md Rakefile export_data.gemspec lib/export_data.rb lib/export_data/version.rb sig/export_data.rbs]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop", "~> 1.0"
  spec.add_development_dependency "yard", "~> 0.9"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_runtime_dependency 'axlsx', '~> 2.0'
  spec.add_runtime_dependency 'roo', '~> 2.0'
  
  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
