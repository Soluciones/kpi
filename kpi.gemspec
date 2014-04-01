$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "kpi/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "kpi"
  s.version     = Kpi::VERSION
  s.authors     = ["Fernan2 - Rankia"]
  s.email       = ["fernando@rankia.com"]
  s.homepage    = "https://github.com/Soluciones/kpi"
  s.summary     = "Guarda datos de Key Performance Indicators y las muestra"
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.12"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "mysql2"
end
