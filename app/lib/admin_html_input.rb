# Add a Formtastic input field for html
class AdminHtmlInput < Formtastic::Inputs::TextInput
  
  def to_html
    input_wrapping do
      label_html << 
      "<div class=\"rich-text-field\">".html_safe <<
      builder.text_area(method, input_html_options) <<
      "</div>".html_safe
    end
  end
  
  def input_html_options
    super.merge(:"data-widget" => "ckeditor")
  end
end