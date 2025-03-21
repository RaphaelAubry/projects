class UsersController < ApplicationController
  before_action :user, only: [ :show, :edit, :update, :destroy ]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      respond_to do |format|
        format.html { redirect_to users_path, notice: "User registered" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @tasks = params[:filter].present? ? @user.tasks.status(params[:filter]) : @user.tasks
    @statuses = params[:filter].present? ? params[:filter] : Task::STATUSES
  end

  def edit
  end

  def update
    @user.update(name: user_params[:name])
    if user_params[:tasks]
      tasks = Task.find(user_params[:tasks].compact_blank)
      @user.tasks << tasks
    end

    if @user.save
      respond_to do |format|
        format.html { redirect_to users_path, notice: "User updated" }
      end
    end
  end

  def destroy
    if @user.destroy
      @user.tasks.each { |task| task.update(user_id: nil) }
      respond_to do |format|
        format.html { redirect_to users_path, notice: "User destroyed" }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, tasks: [])
  end

  def user
    @user = User.find(params[:id])
  end
end
