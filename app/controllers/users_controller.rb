class UsersController < ApplicationController
  before_action :ensure_correct_user, only:[:edit]
  before_action :authenticate_user!


  def index
    @book = Book.new
    @user = current_user
    @users = User.all
  end


  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end


  def edit
      if @user.id != current_user.id
        redirect_to books_path
      end
  end


  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'You have updated user successfully.'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end


  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    @user.save
    redirect_to user_path
  end


  def destroy
  end



  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end


  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_session_path
    end
  end


end



