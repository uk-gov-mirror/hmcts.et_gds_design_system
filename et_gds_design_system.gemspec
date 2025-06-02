$:.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'et_gds_design_system/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'et_gds_design_system'
  spec.version     = EtGdsDesignSystem::VERSION
  spec.authors     = ['Gary Taylor']
  spec.email       = ['gary.taylor@hismessages.com']
  spec.homepage    = 'http://www.google.com'
  spec.summary     = 'Summary of EtGdsDesignSystem.'
  spec.description = 'Description of EtGdsDesignSystem.'
  spec.license     = 'MIT'

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'govuk_design_system_formbuilder', '~> 5.3.0'
  spec.add_dependency 'rails', '>= 6.0'
  spec.add_dependency 'typhoeus', '~> 1.4'
  spec.add_dependency 'rack'

  spec.add_development_dependency 'vite_rails', '~> 3.0'
  spec.add_development_dependency 'turbolinks', '~> 5'
  spec.add_development_dependency 'propshaft', '~> 1.1'
  spec.add_development_dependency 'activerecord-nulldb-adapter', '~> 1.0'
  spec.add_development_dependency 'capybara', '~> 3'
  spec.add_development_dependency 'capybara-screenshot', '~> 1.0'
  spec.add_development_dependency 'dotenv-rails', '~> 3.1'
  spec.add_development_dependency 'rspec-rails', '~> 6.0'
  spec.add_development_dependency 'selenium-webdriver', '~> 4.9'
  spec.add_development_dependency 'site_prism', '~> 5.0'
end
