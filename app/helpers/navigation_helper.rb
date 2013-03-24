module NavigationHelper

  # ca_str = 'controller#action'
  def current_view?(ca_str)
    controller, action, _ = ca_str.split('#')
    (controller && action && params[:controller] == controller && params[:action] == action) ||
    (controller && !action && params[:controller] == controller) ||
    (!controller && action && params[:action] == action)
  end

  def nav_li(*active_for, &block)
    html_attributes = active_for.extract_options!
    html_attributes.stringify_keys!
    html_attributes['class'] ||= ""
    html_attributes['class'] << " active " if active_for.any?{|af| current_view? af }
    content_tag "li", capture(&block), html_attributes
  end
  
end