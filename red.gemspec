# coding: utf-8
$:.push File.expand_path('../lib', __FILE__)
require 'red/version'

Gem::Specification.new do |s|
  s.name        = "red"
  s.version     = Red::VERSION
  s.authors     = ['Jesse Sielaff']
  s.email       = ['jesse.sielaff@gmail.com']
  s.homepage    = ''
  s.summary     = %q{Red writes like Ruby and runs like JavaScript.}
  s.description = %q{Red writes like Ruby and runs like JavaScript.}

  s.rubyforge_project = 'red-js'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
