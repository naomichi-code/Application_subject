class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    if @book_comment.save
      flash[:success] = "Comment was successfully created."
      redirect_to request.referer
    else
      @book_new = Book.new
      @book_comments = @book.book_comments
      render '/books/show'
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.find(params[:id])
    if @book_comment.user == current_user
      @book_comment.destroy
    end
    redirect_to request.referer
  end


  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
