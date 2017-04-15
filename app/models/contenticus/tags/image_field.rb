module Contenticus
module Tags
class ImageField < Base

  attr_reader :aspect_ratio_w, :aspect_ratio_h, :min_size_w, :min_size_h

  def initialize(block, key:, name: nil, comment: nil, parent: parent, aspect_ratio: 'na', min_size: '0x0')
    super block, key: key, name: name, comment: comment, parent: parent
    @aspect_ratio_w, @aspect_ratio_h = aspect_ratio.split(':').map &:to_i
    @min_size_w, @min_size_h = min_size.split('x').map &:to_i
    @values ||= {}
  end

  def aspect_ratio_numeric
    @aspect_ratio_w.to_f / @aspect_ratio_h.to_f
  end

  def image_id
    @values[:image_id]
  end

  def image
    Contenticus::Image.find(image_id)
  end

  def image_exists?
    Contenticus::Image.exists?(image_id)
  end

  def crop_x
    values[:crop_x]
  end

  def crop_y
    values[:crop_y]
  end

  def crop_h
    values[:crop_h]
  end

  def crop_w
    values[:crop_w]
  end

  def options
    ::Contenticus::Image.all.pluck(:file_name, :id)
  end

  def update_attributes(params)
    @values = params.permit(:image_id, :crop_x, :crop_y, :crop_h, :crop_w)
  end

  def cropped_url
    image.file.thumb(crop_command).url
  end

  def crop_command
    "%ix%i+%i+%i" % [crop_w, crop_h, crop_x, crop_y].map(&:to_i)
  end

end
end
end
