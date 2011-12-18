class MyHtmlSanitizer

  def self.clean(str)
    strip_leading_space_from_paragraph( remove_nbsp( basic_cleansing(str) ) )
  end
  
  def self.basic_cleansing(str)
    Sanitize.clean(str, CONFIG)
  end
  
  # Because double spacing and manual indents piss me off. I will win!
  def self.remove_nbsp(str) #and your unicode friends, MWAHAHAHAHA
    str.gsub("&nbsp;", " ").gsub(/\s+/, " ")
  end
  
  # Beacuse I hate people that try to indent things manually...
  def self.strip_leading_space_from_paragraph(str)
    str.gsub /(<p[^>]+>)\s+/, "\\1"
  end
  
  def self.transformer_cleanse_attribute(node_regex, attribute, regex)
    proc do |env| 
      if env[:node_name] =~ node_regex
        node = env[:node]
        if node.has_attribute? attribute
          node.remove_attribute(attribute) unless node.attribute(attribute).try(:value) =~ regex
        end
      end
    end
  end
  
  #
  p_style_attribute = transformer_cleanse_attribute(
    /\Ap|div\Z/, 
    "style",
    /\A(\s*(text-align:\s+(center|right|left|justify)|margin-left:\s+(40|80|120|160)px);\s*)+\Z/
    )
  
  CONFIG = {
      :protocols=>{
        "a"=>{"href"=>["http", "https", :relative]},
      }, 
      :elements=>["a", "abbr", "b", "blockquote", "br", "code", "col",
                  "colgroup", "dd", "dl", "dt", "em", "h1", "h2", "h3", "i", "li",
                  "ol", "p", "pre", "q", "small", "strike", "strong", "sub", "sup",
                  "table", "tbody", "td", "tfoot", "th", "thead", "tr", "tt", "u",
                  "ul"],
      :attributes=>{
        "p" => ["style"],
        "abbr" => ["title"],
        "colgroup"=>["span", "width"], 
        "col"=>["span", "width"], 
        "ul"=>["type"], 
        "a"=>["href", "title", "name"], 
        "q" => ["cite"],
        "blockquote" => ["cite"],
        "td"=>["abbr", "axis", "colspan", "rowspan", "width"], 
        "table"=>["summary", "width"], 
        "ol"=>["start", "type"], 
        "th"=>["abbr", "axis", "colspan", "rowspan", "scope", "width"]
      },
      :add_attributes => {
        'a' => {'rel' => 'nofollow'},
      },
      :transformers => [p_style_attribute]
    }
  
end