$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "et_gds_design_system/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "et_gds_design_system"
  spec.version     = EtGdsDesignSystem::VERSION
  spec.authors     = ["Gary Taylor"]
  spec.email       = ["gary.taylor@hismessages.com"]
  spec.homepage    = "http://www.google.com"
  spec.summary     = "Summary of EtGdsDesignSystem."
  spec.description = "Description of EtGdsDesignSystem."
  spec.license     = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.2", ">= 6.0.2.2"
end
