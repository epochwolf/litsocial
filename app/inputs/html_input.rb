class HtmlInput < SimpleForm::Inputs::Base
  def initialize(*args)
    # formtastic and simple_form use the same namespace for custom inputs, this will 
    # prevent formtsatic from attempting to load this input. 
    raise "Don't use html input type in admin panel, use admin_html." if args.length == 6
    super
  end

  def input
    options = input_html_options
    options[:data] ||= {}
    options[:data][:widget] = 'ckeditor' 
    @builder.text_area attribute_name, options
  end
end