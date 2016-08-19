module InstaArticles
  module ElementTypes
    class Html < Base
      attr_accessor :contents
      attr_accessor :base64

      def initialize(configs = {})
        @base64 = configs["base64"]

        if @base64
          decoded_contents = Base64.decode64(configs["contents"])
          @contents = decoded_contents.force_encoding("utf-8")
        else
          @contents = configs["contents"]
        end
      end
    end
  end
end
