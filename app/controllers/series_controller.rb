class SeriesController < ApplicationController
  require_login except: [:index, :show]
  before_filter :find_series, except:[:index, :new, :create]
  before_filter :check_owner, only: [:edit, :update, :destroy]

  def index
    @series = paged(Series.includes(:user))
  end

  def show
    @series = Series.find(params[:id])
    if !@series.visible? && !owner?(@series)
      show403 "Series not available"
    else
      @user = @series.user
      render layout: 'users'
    end  
  end

  def kindle
    if not @series.visible?
      render json:{status: "error", error: "Series not visible." }
    elsif not current_user.kindle?
      render json:{status: "error", error: "You don't have a kindle email configured." }
    else
      KindleMailer.series_email(current_user.kindle_email, @series).deliver
      render json:{status: "ok", message: "Series sent!" }
    end
  end

  def kindle_preview
    if not @series.visible?
      show403 "Series not available"
    else
      render text: KindleHtml::SeriesWriter.new(@series).to_html
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
  end

  def check_owner
    redirect_to account_path, alert: "Not your series!" unless owner?(@series)
  end
end