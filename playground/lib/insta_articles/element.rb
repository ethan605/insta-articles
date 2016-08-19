module InstaArticles
  class Element < Base
    attr_accessor :wid
    attr_accessor :id
    attr_accessor :type
    attr_accessor :css
    attr_accessor :contents

    attr_accessor :top
    attr_accessor :left
    attr_accessor :width
    attr_accessor :height   

    def contents=(content_configs)
      type_name = @type.split(/[^\w]/).map(&:capitalize).join
      begin
        klass = class_eval("InstaArticles::ElementTypes::#{type_name}")
        @contents = klass.new(content_configs)
      rescue
        @contents = content_configs
      end
    end
  end
end
