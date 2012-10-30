class ReportsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_report, :only => [:update, :destroy]

  def create
    @report = current_user.reports.new(params[:report])
    @reportable = @report.reportable
    render_response(@report.save)
  end
  
  def update
    render_response(@report.update_attributes(params[:report]))
  end
  
  def destroy
    render_response(@report.destroy)
  end

  protected
  def render_response(bool)
    if bool
      render json:{status: "ok", html: render_to_string(partial: "shared/report_link") }
    else
      render json:{status: "error", error: @report.errors, html: render_to_string(partial: "shared/report_link") }
    end
  end
  
  def find_report 
    @report = current_user.reports.find(params[:id])
    @reportable = @report.reportable
  end
end