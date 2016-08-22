module InstaArticles
  class Page
    attr_reader :name
    attr_reader :blocks
    attr_reader :custom_code

    def initialize(filename = "lib/instapage-sample.json")
      raw_data = JSON.parse(File.read(filename))
      mobile_data = raw_data.find {|c| "mobile" == c["responsive_mode"]}
      configs = OpenStruct.new(mobile_data)

      raise "Unable to process (no mobile page config)" unless configs
      
      @name = configs.name

      if configs.custom
        @custom_html = configs.custom.html
        @custom_js = configs.custom.js
      end

      @blocks = configs.page_blocks.map {|block| Block.new(block)}

      assign_elements_to_blocks(configs)
      decode_custom_codes(configs)
    end

    def render(filename = "lib/instapage.html")
      template_file = "lib/insta_articles/views/page.html.haml"
      haml_content = File.read(template_file)
      engine = Haml::Engine.new(haml_content)
      
      File.write(filename, engine.render(self))
    end

    private
    def assign_elements_to_blocks(configs)
      by_blocks = {}

      configs.elements.each do |element|
        is_hidden = element["is_hidden_in_mobile"] == true
        next if is_hidden

        block_id = element["block"]
        by_blocks[block_id] ||= []
        by_blocks[block_id] << Element.new(element)
      end

      @blocks.each {|block| block.elements = by_blocks[block.id] || []}
    end

    def decode_custom_codes(configs)
      @custom_code = {}
      
      %w[html js].each do |type|
        @custom_code[type] = {}

        %w[head body footer].each do |position|
          code = Base64.decode64(configs.custom_code[type][position]).force_encoding("utf-8")
          @custom_code[type][position] = code
        end
      end
    end
  end
end
