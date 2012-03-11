class WatchesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_watch, :only => [:update, :destroy]

  def create
    @watch = current_user.watches.new(params[:watch])
    @watchable = @watch.watchable
    render_response(@watch.save)
  end
  
  def update
    render_response(@watch.update_attributes(params[:watch]))
  end
  
  def destroy
    render_response(@watch.destroy)
  end

  protected
  def render_response(bool)
    if bool
      render :json => {:status => "ok", :html => render_to_string(:partial => "shared/watch_link") }
    else
      render :json => {:status => "error", :error => @watch.errors, :html => render_to_string(:partial => "shared/watch_link") }
    end
  end
  
  def find_watch 
    @watch = current_user.watches.find(params[:id])
    @watchable = @watch.watchable
  end
end