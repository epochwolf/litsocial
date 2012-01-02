module ApplicationHelper
  
  def tb_form_for(*args, &block)
    twitter_bootstrap_form_for(*args, &block)
  end
  
  def continue_redirect
  end
  
  def user_link(user)
    if user.nil?
      content_tag('em', "None")
    else
      link_to user.name, user
    end
  end
  
  def rich(html)
    sanitize(html)
  end
  
  def b(boolean)
    boolean ? "yes" : "no"
  end
  
  def dt(datetime)
    datetime ? datetime.strftime("%b %d, '%y at %l:%M") : 'Unknown'
  end
  
end
