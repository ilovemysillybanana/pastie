class UsersController < ApplicationController
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
end
