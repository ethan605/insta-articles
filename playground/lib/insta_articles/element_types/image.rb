module InstaArticles
  module ElementTypes
    class Image < BaseElement
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

      def html_content
        html = "<img src='#{@image}' title='#{@title}' alt='#{@alt}'>"

        unless @link.blank?
          @link.wrap(html)
        else
          html
        end
      end
    end
  end
end
