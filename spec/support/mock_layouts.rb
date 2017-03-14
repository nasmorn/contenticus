module MockLayouts

  def mock_layout(file)
    root_path.join(file)
  end

  private

  def root_path
    Pathname.new File.expand_path("layouts", File.dirname(__FILE__))
  end

end