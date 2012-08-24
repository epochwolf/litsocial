class SeriesController < ApplicationController

  def index
    @series = paged(Series.includes(:user))
  end

  def show
    @series = Series.find(params[:id])
    if !@series.visible? && !owner?(@story)
      show403 "Story not available"
    end  
  end
end