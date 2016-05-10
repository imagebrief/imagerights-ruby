require_relative 'image_rights/user'
require_relative 'image_rights/image'
require_relative 'image_rights/connection'
require_relative 'image_rights/exceptions'
# Configuration block to set Partner Key

module ImageRights
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    # Non Configurable Settings
    DEFAULT_URL = 'https://www.imagerights.com/api/v1/tool'.freeze

    # Configurable Settings
    attr_accessor :partner_key
  end
end