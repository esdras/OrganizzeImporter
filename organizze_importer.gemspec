# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "organizze_importer/version"

Gem::Specification.new do |s|
  s.name        = "organizze_importer"
  s.version     = OrganizzeImporter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Esdras Mayrink"]
  s.email       = ["falecom@oesdras.com.br"]
  s.homepage    = "http://oesdras.com.br"
  s.summary     = %q{A lib to parse files and convert them into a default structure}
  s.description = %q{Parses a set of files of several formats and returns all attributes}

  s.rubyforge_project = "organizze_importer"

  s.add_development_dependency 'rspec'

  s.add_dependency "ofx"
  s.add_dependency "activesupport"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
