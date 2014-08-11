class WelcomeController < ApplicationController
  def index
    if params[:project_id]
      @projects = [Project.find(params[:project_id])]
    else
      @projects = Project.all
    end
    render 'index'
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new entry_params
    if @project.save
      redirect_to action: "index", controller: "entries", project_id: @project.id
    else
      render "new"
    end
  end

  private 

  def entry_params
    params.require(:project).permit(:name, :description)
  end
end