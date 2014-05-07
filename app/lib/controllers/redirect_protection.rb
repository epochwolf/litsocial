module Controllers
module RedirectProtection
  def self.included(mod)
    mod.before_filter :protect_from_invalid_redirect
    mod.helper_method :return_path, :return_path?, :here
  end
  
  def redirect(*args)
    if return_path?
      redirect_to return_path, args.last.is_a?(Hash) ? args.last : {}
    else
      redirect_to *args
    end
  end
  
  def here
    request.url
  end
  
  def return_path(path_if_nil=nil)
    params[:return] || path_if_nil || root_path
  end
  
  def return_path?
    !!params[:return]
  end
  
  protected
  def protect_from_invalid_redirect
    regex = /\A(http(s?):\/\/#{request.host_with_port}|\/\Z|\/[^\/])/ # address of the current request
    if @invalid_redirect_url = params[:return] # address of redirect
      render("errors/invalid_redirect") unless @invalid_redirect_url.blank? or @invalid_redirect_url =~ regex
    end
  end
end
end
