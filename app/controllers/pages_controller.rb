class PagesController < ApplicationController
  layout 'pages'

  def index
    @pages = paged(Page.visible)
  end

  def show
    show404 "Didn't find any page named \"#{params[:id]}\"." unless @page = Page.find_by_id_or_url(params[:id])
  end
end