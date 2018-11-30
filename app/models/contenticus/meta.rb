class Contenticus::Meta
  include ActionView::Helpers

  def self.from_page(page)
    title = page.meta.tag(:title).value
    title = page.slug.label if title.blank?
    Contenticus::Meta.new({
      title: title,
      description: page.meta.tag(:description).value,
      index: !page.meta.tag(:no_index).value,
    })
  end

  def initialize(params = {})
    @title = params[:title] || ""
    @description = params[:description]
    @index = params[:index].nil? ? true : params[:index]
    @index = false if Contenticus.config.meta_no_index
  end

  def render
    tags = []
    tags << content_tag(:title, title)
    tags << content_tag(:meta, '', name: "description", content: @description) unless @description.blank?
    tags << content_tag(:meta, '', name: "robots", content: robots_content)
    tags.join.html_safe
  end

  def title
    if @title.length + append_title.length <= title_max_length
      @title + append_title
    else
      @title
    end
  end

  private

  def title_max_length
    Contenticus.config.meta_title_max_characters
  end

  def append_title
    Contenticus.config.meta_title_append
  end

  def robots_content
    if @index
      "index, follow"
    else
      "noindex, follow"
    end
  end

end
