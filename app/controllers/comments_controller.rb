class CommentsController < ApplicationController
  before_action :authenticate_user!, :except => [:show]
  

  def create
    @comment = Comment.new(params[comment_params])
    @comment.listing_id = params[:listing_id]
    @comment.user_id = current_user.id
    @comment.body = params[:comment][:body]

    if @comment.save
      flash[:success] = "Comment Successful."
      redirect_to listing_path(@comment.listing)
    else
      flash[:alert] = "Comment Failed."
    end
  end

  def destroy
    @comment = @listing.comments.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment Removed."
    redirect_to listing_path(@listing)
  end

  private
  def comment_params
    params.require(:comment).permit(:user, :body)
  end
end
