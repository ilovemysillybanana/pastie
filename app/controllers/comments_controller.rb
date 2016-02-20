class CommentsController < ApplicationController
  before_action :authenticate_user!, :except => [:show]
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :downvote, :upvote]

  def create
    @comment = Comment.new(params[comment_params])
    @comment.listing_id = params[:listing_id]
    @comment.user_id = current_user.id
    @comment.body = params[:comment][:body]

    respond_to do |format|
      if @comment.save && @comment.valid?
        format.html { redirect_to listing_path(@comment.listing), alert: "Comment Successful."}
        format.js
        UserNotifier.comment_reply_email(@comment).deliver_later
      else
        format.html { redirect_to listing_path(@comment.listing), alert: "#{@comment.errors.full_messages}"}
        format.js
      end
    end
  end

  def upvote
    @comment.upvote_from current_user
    redirect_to listing_path(@comment.listing_id)
  end

  def downvote
    @comment.downvote_from current_user
    redirect_to listing_path(@comment.listing_id)
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

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
