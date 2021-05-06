class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @book = Book.new
    @books = Book.all.order(created_at: :desc)
    @user = current_user
  end

  def create
    @books = Book.all
    @user = current_user
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "successfully"
    else
      render :index
    end
  end

  def show
    @book1 = Book.new
    @book = Book.find(params[:id])
    @user = @book.user

    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "successfully"
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, notice: "Destroy Book successfully"
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  before_action :ensure_current_user, only: [:edit]
  def ensure_current_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end
