module InstaArticles
  class Page
    attr_reader :name
    attr_reader :blocks
    attr_reader :custom_html
    attr_reader :custom_js

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
  end
end
