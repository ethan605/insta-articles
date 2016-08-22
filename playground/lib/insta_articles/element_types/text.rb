module InstaArticles
  module ElementTypes
    class Text < BaseElement
      attr_accessor :html
      attr_accessor :text_align
      attr_accessor :font_color
      attr_accessor :links

      def html_content
        @html
      end
    end
  end
end
