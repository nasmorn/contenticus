# encoding: utf-8

class Contenticus::Configuration

  # All pages will return no_index
  # e.g. for staging environments
  attr_accessor :meta_no_index

  # Text to append to all short enough meta titles
  # e.g. " | Jumping Bean Limited"
  attr_accessor :meta_title_append

  # Maximum amount of characters a title can have including the appended text
  attr_accessor :meta_title_max_characters

  # Configuration defaults
  def initialize
    @meta_no_index = false
    @meta_title_append = ""
    @meta_title_max_characters = 60
  end

end
