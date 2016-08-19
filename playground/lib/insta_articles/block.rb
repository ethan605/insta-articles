module InstaArticles
  class Block < Base
    attr_accessor :id
    attr_accessor :height
    attr_accessor :background_color
    attr_accessor :background_image
    attr_accessor :elements    
  end

  def background_image=(image_url)
    @background_image = normalized_url(image_url)
  end
end
