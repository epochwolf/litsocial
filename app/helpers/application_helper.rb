# encoding: utf-8
module ApplicationHelper
  
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

  def gravatar(user, size)
    image_tag(user.gravatar_url(size), class: 'gravatar', size: "#{size}x#{size}")
  end

  def user_link(user)
    link_to gravatar(user, 16) + h(user.name), user, class:'user-link'
  end
  
  # def user_link(user)
  #   if user.nil?
  #     ctag('em', "None")
  #   else
  #     menu = {}
  #     menu[["user", "Profile"]] = user
  #     menu[["book", "Stories"]] = [:stories, user]
  #     if user_signed_in?
  #       menu["0"] = :divider
  #       menu[["envelope", "Send Message"]] = new_account_message_path(current_user, to:user.id)
  #     end 
  #     dropdown_menu(user.name, menu)
  #   end 
  # end
  
  def icon(name)
    "<i class='icon-#{name}'></i> ".html_safe
  end
  
  def icon_link(icon_name, name, *args)
    link_to(icon(icon_name) + h(name), *args)
  end
  
  def rich(html)
    MyHtmlSanitizer.clean(html)
  end
  
  def b(boolean)
    boolean ? "yes" : "no"
  end
  
  def dt(datetime)
    datetime.respond_to?(:strftime) ? datetime.strftime("%b %d, '%y at %l:%M") : 'Unknown'
  end
  
  def short_date(datetime)
    datetime.respond_to?(:strftime) ? datetime.strftime("%b %d, '%y") : 'Unknown'
  end

  def edit_links(object)
    return unless owner?(object) || admin?
    content_tag :small do
      str = "".html_safe
      if owner?(object)
        str << raw("&nbsp;")
        str << icon_link('wrench', "edit", polymorphic_path([:edit, object], return: here))
        if Series === object
          str << raw("&nbsp;")
          str << icon_link("plus", "add a story", new_story_path(series: object.id, return: here))
        end
      end
      if admin?
        str << raw("&nbsp;")
        str << icon_link('qrcode', "admin", [:admin, object]) 
      end
      str
    end
  end

  def admin_link(object)
    content_tag :small do
      return unless admin?
      str = "".html_safe
      str << raw("&nbsp;")
      str << icon_link('qrcode', "admin", [:admin, object]) 
      str
    end
  end

end