# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yahoo_fantasy_sports_client/version'

Gem::Specification.new do |spec|
  spec.name          = "yahoo_fantasy_sports_client"
  spec.version       = YahooFantasySportsClient::VERSION
  spec.authors       = ["Mark Borcherding"]
  spec.email         = ["markborcherding@gmail.com"]
  spec.description   = %q{A client library for talking to Yahoo Fantasy Sports APIs}
  spec.summary       = %q{A client library for talking to Yahoo Fantasy Sports APIs}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "oauth"
  spec.add_dependency "happymapper"


  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "interactive_editor"
  spec.add_development_dependency "awesome_print"
  spec.add_development_dependency "wirb"
  spec.add_development_dependency "highline"
  spec.add_development_dependency "debugger"
end
