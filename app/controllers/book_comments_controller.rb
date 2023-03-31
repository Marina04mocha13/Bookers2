class BookCommentsController < ApplicationController

  def create
    @book_id = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book_id.id
    comment.save
    render "books/replace_comment"
  end

  def destroy
    @book_id = Book.find(params[:book_id])
    BookComment.find(params[:id]).destroy
    render "books/replace_comment"
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
