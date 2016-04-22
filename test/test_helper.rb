require './lib/image_rights'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'
require 'pry-rescue/minitest'

VCR.configure do |c|
  c.cassette_library_dir = "test/fixtures"
  c.hook_into :webmock
end

ImageRights.configure do |c|
  c.partner_key = ENV["IMAGERIGHTS_TEST_KEY"]
end

FIXTURES_PATH = File.expand_path File.dirname(__FILE__) + '/fixtures'
