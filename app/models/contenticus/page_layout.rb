class Contenticus::PageLayout < Contenticus::Layout

  def initialize(identifier)
    super identifier, "pages"
  end

  def self.available
    available_for("pages")
  end

end