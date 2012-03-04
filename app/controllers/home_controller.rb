class HomeController < ApplicationController
  def index
    @literatures = Literature.visible.sorted.limit(5)
    @posts = NewsPost.visible.sorted.limit(5)
  end
  
  def four_oh_three
    show403
  end
  
  def four_oh_four
    show404
  end
end