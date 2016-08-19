module InstaArticles
  class Base
    def initialize(configs = {})
      configs.keys.each do |key|
        send("#{key}=", configs[key]) if respond_to?("#{key}=")
      end
    end

    def normalized_url(insta_url)
      return nil unless insta_url

      if insta_url =~ /^http:/
        insta_url
      else
        "http:" + insta_url
      end
    end
  end
end
