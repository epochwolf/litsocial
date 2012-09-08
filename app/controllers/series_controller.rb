class SeriesController < ApplicationController
  require_login except: [:index, :show]
  before_filter :find_series, except:[:index, :new, :create]

  def index
    @series = paged(Series.includes(:user))
  end

  def show
    @series = Series.find(params[:id])
    if !@series.visible? && !owner?(@series)
      show403 "Series not available"
    end  
  end

  def new
    @series = current_user.series.build
  end

  def create
    @series = current_user.series.build(params[:series])
    if @series.save
      redirect_to return_path(@series), notice: "Series saved!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @series.update_attributes(params[:series])
      redirect_to return_path(@series), notice: "Series updated!"
    else
      render :edit
    end
  end

  def destroy
    @series.destroy
    redirect_to return_path(account_path), alert: "Series deleted"
  end

  private
  def find_series
    @series = Series.find(params[:id])
    redirect_to account_path, alert: "Not your series!" if params[:action] != "show" && !owner?(@series)
  end
end