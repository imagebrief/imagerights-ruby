# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'image_rights/version'

Gem::Specification.new do |spec|
  spec.name          = "image_rights"
  spec.version       = ImageRights::VERSION
  spec.authors       = ["Harry Curotta"]
  spec.email         = ["harry@imagebrief.com"]
  spec.description   = %q{A Ruby wrapper for the ImageRights API}
  spec.summary       = %q{A Ruby wrapper for the ImageRights API}
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.files         = Dir['lib/**/*.rb']
  
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry-rescue"
  spec.add_development_dependency "pry"

  spec.add_dependency "faraday"
  spec.add_dependency "json"

end