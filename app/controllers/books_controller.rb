class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice: "You have created book successfully."
    else
      @books = Book.all
      render action: :index
    end
  end

  def index
    @books = Book.includes(:favorites).sort {|x, y| y.favorites.count <=> x.favorites.count}
    @book = Book.new
  end

  def show
    @book_id = Book.find(params[:id])
    @book = Book.new
    @user = @book_id.user
    @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
    @user = @book.user
    if @user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "You have updated book successfully."
    else
      render action: :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
