class Contenticus::BlockLayout < Contenticus::Layout

  def initialize(identifier, block)
    super identifier, block, "blocks"
  end

  def self.available
    available_for("blocks")
  end

end