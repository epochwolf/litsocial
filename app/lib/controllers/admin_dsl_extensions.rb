module Controllers
module AdminDslExtensions
  def set_creator(f)
    f.object.user = current_user if f.object.new_record?
  end
  
  def current_user
    @current_user ||= config.controller.new.current_user
  end
  
end
end