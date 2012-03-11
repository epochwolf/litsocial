module ApplicationHelper
  
  def tb_form_for(*args, &block)
    twitter_bootstrap_form_for(*args, &block)
  end
  
  def continue_redirect
    hidden_field_tag "return", return_path if return_path?
  end
  
  def ctag(*args, &block) 
    content_tag(*args, &block)
  end
  
  def dropdown_menu(title, menu={})
    id = rand(1_000_000_000)
    title = "#{h title}<b class='caret'></b>".html_safe
    link = link_to(title, "#", class:"dropdown-toggle", data:{toggle:"dropdown", target:"##{id}"})
    menu = ctag("ul", class:"dropdown-menu") do
      menu.map do |name, link|
        if link == :divider
          ctag("li", "", class:'divider')
        elsif name.is_a? Array
          ctag("li"){ icon_link name[0], name[1], link }
        else
          ctag("li"){ link_to name, link }
        end.html_safe
      end.map(&:html_safe).join("".html_safe).html_safe
    end.html_safe
    ctag("span", id:id, class:'dropdown') do
      link + menu
    end
  end
  
  def user_link(user)
    if user.nil?
      ctag('em', "None")
    else
      menu = {}
      menu[["user", "Profile"]] = user
      menu[["book", "Stories"]] = [:stories, user]
      menu[["glass", "Poems"]] = [:poems, user]
      if user_signed_in?
        menu["0"] = :divider
        menu[["envelope", "Send Message"]] = new_account_message_path(current_user, to:user.id)
      end 
      dropdown_menu(user.name, menu)
    end 
  end
  
  def icon(name)
    "<i class='icon-#{name}'></i> ".html_safe
  end
  
  def icon_link(icon_name, name, *args)
    link_to(icon(icon_name) + h(name), *args)
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
