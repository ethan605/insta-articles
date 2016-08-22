module InstaArticles
  module ElementTypes
    class Link < Base
      attr_accessor :id
      attr_accessor :type
      attr_accessor :href

      def wrap(html)
        if @type == "onpage"
          "<a href='#{@href}'>#{html}</a>"
        else
          "<a href=''>#{html}</a>"
        end
      end
    end
  end
end
