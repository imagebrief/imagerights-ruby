# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'image_rights/version'

Gem::Specification.new do |spec|
  spec.name          = "image_rights"
  spec.version       = ImageRights::VERSION
  spec.authors       = ["Harry Curotta"]
  spec.email         = ["harry@imagebrief.com"]
  spec.description   = %q{ImageRights API}
  spec.summary       = %q{A Ruby wrapper for the ImageRights API}
  spec.homepage      = "https://github.com/imagebrief/imagerights-ruby"
  spec.license       = "MIT"
  spec.files         = Dir['lib/**/*.rb']
  
  spec.add_development_dependency "minitest", "~> 5.8"
  spec.add_development_dependency "vcr", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 1"
  spec.add_development_dependency "pry-rescue", "~> 1.4"
  spec.add_development_dependency "pry", "~> 0.10"

  spec.add_dependency "faraday", "~> 0.9"
end