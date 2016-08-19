module InstaArticles
  module ElementTypes
    class Image < Base
      attr_accessor :image
      attr_accessor :image_width
      attr_accessor :image_height
      attr_accessor :title
      attr_accessor :alt
      attr_accessor :link

      def image=(image_url)
        @image = normalized_url(image_url)
      end

      def link=(link_config)
        @link = Link.new(link_config)
      end
    end
  end
end
