class ProjectsController < ApplicationController
  before_action :project, only: [ :show, :edit, :update, :destroy ]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.create(project_params)

    if @project.save
      respond_to do |format|
        format.html { redirect_to projects_path, notice: "Project registered" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @tasks = params[:filter].present? ? @project.tasks.status(params[:filter]) : @project.tasks
    @statuses = params[:filter].present? ? params[:filter] : Task::STATUSES
  end

  def edit
  end

  def update
    if @project.update(project_params)
      respond_to do |format|
        format.html { redirect_to projects_path, notice: "Project updated" }
      end
    else
      render "edit"
    end
  end

  def destroy
    if @project.destroy
      respond_to do |format|
        format.html { redirect_to projects_path, notice: "Project destroyed" }
      end
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def project
    @project = Project.find(params[:id])
  end
end
