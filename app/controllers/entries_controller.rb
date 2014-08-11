class EntriesController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @entries = @project.entries
    @totalHours = @project.total_hours_in_month(Time.now.month, Time.now.year)
    rescue
      render text: "That project is not here!"
  end

  def new
    @project = Project.find(params[:project_id])
    @entry = Entry.new
  end

  def create
    @project = Project.find(params[:project_id])
    @entry = @project.entries.new entry_params
    if @entry.save
      redirect_to action: "index", controller: "entries", project_id: @project.id
    else
      render "new"
    end
  end

  private 

  def entry_params
    params.require(:entry).permit(:hours, :minutes, :date)
  end
end
