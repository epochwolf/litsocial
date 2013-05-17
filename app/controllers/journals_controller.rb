class JournalsController < ApplicationController
  require_login except: [:show]
  before_filter :find_journal, only: [:show, :edit, :update, :destroy]
  before_filter :new_journal, only: [:new, :create]
  layout 'pages'

  def show
    if !@journal.visible? && !owner?(@journal)
      render 'errors/journal_403', status: 403
    end
  end

  def new
  end

  def create
    if @journal.save
      redirect_to return_path(journals_account_path), notice: "Journal saved."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @journal.update_attributes(params[:journal])
      redirect_to return_path(@journal), notice: "Journal updated!"
    else
      render :edit
    end
  end

  def destroy
    @journal.update_column :deleted, true
    redirect_to return_path(journals_account_path), alert: "Journal deleted!"
  end
  

  private
  def new_journal
    @journal = current_user.journals.build(params[:journal])
  end

  def find_journal
    @journal = Journal.find(params[:id])
  end
end