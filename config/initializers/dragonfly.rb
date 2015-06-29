require 'dragonfly'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "2cf4ad72c65c2b4401cc000907b459b13aeac5315ef8ec354945a8d16ea6b0e1"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join('public/system/dragonfly', Rails.env),
    server_root: Rails.root.join('public')
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
