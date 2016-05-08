class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)

    if @comment.save
      redirect_to post_path(comment_params[:post_id])
      flash[:success] = "Comment Updated!"
    else
      flash[:error] = "An error ocurred, Comment not updated!"
      render 'edit'
    end
  end


  private

  def comment_params
    params.require(:comment).permit(:id, :body, :user_id, :post_id)
  end
end
