module Contenticus::AdminMarkupHelper

  def btn_collapse(open, target:, css_classes: 'btn-default')
    css_classes = 'btn ' + css_classes
    css_classes = css_classes + ' collapsed' unless open
    content_tag('div', class: css_classes, 'data-target' => target, 'data-toggle' => 'collapse') do
      capture do
        concat content_tag('span', '', class: 'glyphicon glyphicon-triangle-right')
        concat content_tag('span', '', class: 'glyphicon glyphicon-triangle-bottom')
      end
    end
  end

  def tag_toolbar(tag, collapse: nil, &block)
    extra = if block_given? then capture(&block) end
    render 'contenticus/admin/shared/tag_toolbar', tag: tag, collapse: collapse, collectible: tag.collectible?, extra: extra
  end

  def icon(name)
    content_tag('span', class: "glypicon glypicon-#{name}")
  end

end
