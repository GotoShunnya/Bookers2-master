class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:index, :show, :edit]

  def top
  end

  def index
    @book= Book.new
    @users= User.all
    @user= current_user
  end

  def create
    @user= User.find(params[:id])
    @books= @user.books

    @book= Book.new(book_params)
    @book.user_id = current_user.id
  if @book.save
    redirect_to book_path(@book.id)
  else
    render :show
  end
  end

  def show
    @book1= Book.new

    @user= User.find(params[:id])
    @books= @user.books

  end

  def edit
    @user= User.find(params[:id])
    if
    @user == current_user
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user= User.find(params[:id])
  if @user.update(user_params)
    redirect_to user_path
  else
    render :edit
  end
  end

private

def user_params
  params.require(:user).permit(:name, :profile_image, :introduction)
end
end
