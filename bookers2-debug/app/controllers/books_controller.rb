class BooksController < ApplicationController
  before_action :authenticate_user!,only:[:edit,:destroy]

  def show
    @book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def create
    @user = current_user
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if  @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    redirect_to root_path unless current_user.id == @book.user_id
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if  @book.save
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book)
    else
      @books = Book.all
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

end
