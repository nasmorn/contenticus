class Contenticus::File < ActiveRecord::Base
  self.table_name = "contenticus_files"

  dragonfly_accessor :file

end