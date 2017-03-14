class Contenticus::Image < ActiveRecord::Base
  self.table_name = "contenticus_images"

  belongs_to :block

  dragonfly_accessor :file

end