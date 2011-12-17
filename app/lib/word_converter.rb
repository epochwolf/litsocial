class WordConverter
  def initialize(raw_html)
    @raw_html = raw_html
  end
  
  def self.html_from_file(file)
    `unoconv "#{file}"`
  end
  
  attr_reader :raw_html, :processed_html
  
  def to_html()
    return @html if defined? @html
    @html = extract_body()
  end
  
  protected
  def extract_body()
    
  end
end