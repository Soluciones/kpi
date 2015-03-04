$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'kpi/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'kpi'
  s.version     = Kpi::VERSION
  s.authors     = ['Fernan2 - Rankia']
  s.email       = ['fernando@rankia.com']
  s.homepage    = 'https://github.com/Soluciones/kpi'
  s.summary     = 'Guarda datos de Key Performance Indicators y las muestra'
  s.description = ''

  s.files = Dir['{app,config,db,lib}/**/*'] + ['MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.2'

  s.add_dependency 'pg'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rspec-instafail'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'database_cleaner'
end
