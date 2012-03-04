class PagesController < ApplicationController
  
  def index
    @pages = paged(Page.visible)
  end
  
  def show
    @page = Page.visible.find_by_url_or_id!(params[:id])
  end
end