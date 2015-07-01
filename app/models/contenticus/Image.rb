class Contenticus::Image < ActiveRecord::Base
  self.table_name = "contenticus_images"

  dragonfly_accessor :file

end