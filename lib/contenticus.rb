# Loading engine only if this is not a standalone installation
unless defined? Contenticus::Application
  require_relative 'contenticus/engine'
end

require_relative 'contenticus/routing'