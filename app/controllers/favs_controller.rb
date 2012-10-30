class FavsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_fav, :only => [:update, :destroy]

  def create
    @fav = current_user.favs.new(params[:fav])
    @favable = @fav.favable
    render_response(@fav.save)
  end
  
  def update
    render_response(@fav.update_attributes(params[:fav]))
  end
  
  def destroy
    render_response(@fav.destroy)
  end

  protected
  def render_response(bool)
    if bool
      render json:{status: "ok", html: render_to_string(partial: "shared/fav_link") }
    else
      render json:{status: "error", error: @fav.errors, html: render_to_string(partial: "shared/fav_link") }
    end
  end
  
  def find_fav 
    @fav = current_user.favs.find(params[:id])
    @favable = @fav.favable
  end
end