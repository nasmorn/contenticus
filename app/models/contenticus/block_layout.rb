class Contenticus::BlockLayout < Contenticus::Layout

  def initialize(identifier)
    super identifier, "blocks"
  end

  def self.available
    available_for("blocks")
  end

end