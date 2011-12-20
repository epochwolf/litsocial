require 'nokogiri'

class WordConverter
  attr_reader :raw_html, :html
  
  def initialize(raw_html)
    puts raw_html
    @raw_html = raw_html
  end
  
  
  def to_html()
    return @html if defined? @html
    @html = self.class.extract_body(@raw_html)
    @html = self.class.cleanse_html(@html)
  end
  
  class << self
    def html_from_file(filename)
      html = `tx"#{filename}"`
      WordConverter.new(html).to_html
    end
  
    def extract_body(html)
      if doc = Nokogiri::HTML::Document.parse(html)
        if body = doc.xpath('/html/body')
          return doc.xpath("//html/body").children.to_html
        end
      end
      return html
    end
    
    def cleanse_html(html)
      MyHtmlSanitizer.clean(html)
    end
  end
  
end