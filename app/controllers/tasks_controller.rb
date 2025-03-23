class TasksController < ApplicationController
  before_action :task, only: [ :edit, :update, :destroy, :unassign, :assign, :assignate ]
  before_action :project, only: [ :new, :create ]

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
    else
      render "edit"
    end
  end

  def unassign
    if @task.update(user_id: nil)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to project_path(@task.project), notice: "Task unassigned" }
      end
    else
      render "unassign"
    end
  end

  def assign
  end

  def assignate
    if @task.update(task_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to project_path(@task.project), notice: "Task assigned" }
      end
    else
      render "assign"
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
    params.require(:task).permit(:name, :description, :project_id, :user_id, :status)
  end

  def task
    @task = Task.find(params[:id])
  end

  def project
    @project = Project.find(params[:project_id])
  end
end
