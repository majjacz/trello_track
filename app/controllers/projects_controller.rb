class ProjectsController < ApplicationController
  before_action :set_project, only: [:edit, :update, :destroy]
  before_filter :require_admin

  def index
    @projects = Project.all
  end

  def edit
  end

  def update
    if @project.update(project_params)
      redirect_to projects_url, notice: 'Project was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :board_id)
    end
end
