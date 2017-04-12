# Loading engine only if this is not a standalone installation
unless defined? Contenticus::Application
  require_relative 'contenticus/engine'
end

require_relative 'contenticus/configuration'
require_relative 'contenticus/routing'

module Contenticus
  class << self

    def configure
      yield configuration
    end

    # Accessor for ComfortableMexicanSofa::Configuration
    def configuration
      @configuration ||= Configuration.new
    end
    alias :config :configuration

  end

end
