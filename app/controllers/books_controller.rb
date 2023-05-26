class BooksController < ApplicationController

  def create
    @new = Book.new(book_params)
    @new.user_id = current_user.id
    if @new.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@new.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def index
    @books = Book.all
    @new = Book.new
    @user = current_user
  end

  def show
    @new = Book.new
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "You have destroyed book successfully."
    redirect_to '/books'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
