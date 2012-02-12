class HomeController < ApplicationController
  def index
    @literatures = Literature.visible.sorted.limit(5)
    @posts = NewsPost.visible.sorted.limit(5)
  end
end