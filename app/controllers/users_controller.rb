class UsersController < ApplicationController
  before_action :authenticate_user!, :except => [:show]
  before_action :set_voting_user, only: [:show, :downvote, :upvote]
  clear_respond_to
  respond_to :html, :js, :json

  def show
    @user = User.find(params[:id])

    respond_to do |format|
        format.html # show.html.erb
        format.js
        format.xml { render :xml => @user }
    end
  end

  def upvote
    @user.upvote_from current_user
    redirect_to :back
  end

  def downvote
    @user.downvote_from current_user
    redirect_to :back
  end

  private
  def set_voting_user
    @user = User.find(params[:id])
  end
end
