module InstaArticles
  module ElementTypes
    class Headline < BaseElement
      attr_accessor :html
      attr_accessor :headline_type
      attr_accessor :text_align
      attr_accessor :font_color

      def html_content
        "<h1>#{@html}</h1>"
      end
    end
  end
end
