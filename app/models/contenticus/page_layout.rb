class Contenticus::PageLayout < Contenticus::Layout

  def initialize(identifier, block)
    super identifier, block, "pages"
  end

  def self.available
    available_for("pages")
  end

end