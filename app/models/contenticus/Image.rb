class Contenticus::Image < ActiveRecord::Base
  self.table_name = "contenticus_images"

  belongs_to :block

  validates_presence_of :file_name, :file_uid
  dragonfly_accessor :file

end
