class ListingsController < ApplicationController
  before_action :authenticate_user!, :except => [:search,:show, :index]
  before_action :set_listing, only: [:show, :edit, :update, :destroy, :downvote, :upvote]

  def search
    if params[:search]
      @listings = Listing.search(params[:search])
    else
      @listings = Listing.all
    end
  end

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.all.paginate(:page => params[:page], :per_page => 25).order('created_at DESC')
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @comment = Comment.new
    @comment.listing_id = @listing_id
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
    if @listing.user != current_user
      flash[:alert] = 'You can not edit other users posts. If this is your account sign in.'
      redirect_to root_path
    end
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Listing was successfully created.' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Listing was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    if @listing.user == current_user
      @listing.destroy
      respond_to do |format|
        format.html { redirect_to listings_url, notice: 'Listing was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      flash[:alert] = 'You can not edit other users posts. If this is your account sign in.'
      redirect_to root_path
    end

  end

  def upvote
    @listing.upvote_from current_user
    redirect_to :back
  end

  def downvote
    @listing.downvote_from current_user
    redirect_to :back
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:name, :code, :language)
    end
end
