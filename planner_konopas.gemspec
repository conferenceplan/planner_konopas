$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "planner_konopas/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "planner_konopas"
  s.version     = PlannerKonopas::VERSION
  s.authors     = ["Henry Balen"]
  s.email       = ["info@grenadine.co"]
  s.licenses    = ["Apache"]
  s.homepage    = "http://www.myconferenceplanning.org"
  s.summary     = "REST API to support Konopas."
  s.description = "REST API to support Konopas."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE", "Rakefile"]

  s.add_dependency 'rails', '~> 4.2.0'
  s.add_dependency "globalize"
  s.add_dependency 'devise'
  s.add_dependency 'planner-core'

  s.add_development_dependency "sqlite3"
end
