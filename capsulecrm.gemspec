# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "capsulecrm/version"

Gem::Specification.new do |s|
  s.name        = "capsulecrm"
  s.version     = CapsuleCRM::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ahmed Adam"]
  s.email       = ["ahmed.msgs@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{CapsuleCRM API Gem}
  s.description = %q{CapsuleCRM API Gem}

  s.add_dependency 'httparty', '>= 0.7.4'
  s.add_dependency 'activemodel', '>= 3.0.5'
  s.add_dependency 'activesupport', '>= 3.0.5'

  s.rubyforge_project = "capsulecrm"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
