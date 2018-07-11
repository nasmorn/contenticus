class Contenticus::Image < ActiveRecord::Base
  self.table_name = "contenticus_images"

  belongs_to :block

  validates_presence_of :file_name, :file
  dragonfly_accessor :file
end
