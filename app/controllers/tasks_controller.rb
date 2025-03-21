class TasksController < ApplicationController
  before_action :task, only: [ :edit, :update, :destroy ]
  before_action :project, only: [:new, :create]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
     @task.project = @project

    if @task.save
      respond_to do |format|
        format.html { redirect_to project_path(@project), notice: "Task registered" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      respond_to do |format|
        format.html { redirect_to project_path(@task.project), notice: "Task updated" }
      end
    end
  end

  def destroy
    if @task.destroy
      respond_to do |format|
        format.html { redirect_to project_path(@task.project), notice: "Task destroyed" }
      end
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :project_id)
  end

  def task
    @task = Task.find(params[:id])
  end

  def project
    @project = Project.find(params[:project_id])
  end
end
