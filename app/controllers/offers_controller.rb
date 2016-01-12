class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  # GET /offers
  # GET /offers.json
  def index
    @offers = Offer.all
    @events = Event.all
    @user = current_user

    @confirmedoffers = Offer.where(:client_confirmation => true)
    @rejectedoffers = Offer.where(:client_confirmation => false)
    @pendingoffers = Offer.where(:client_confirmation => nil)

    @myoffers = Offer.where(:organizer => current_user)
    @myconfirmedoffers = @myoffers.where(:client_confirmation => true)
    @myrejectedoffers = @myoffers.where(:client_confirmation => false)
    @mypendingoffers = @myoffers.where(:client_confirmation => nil)

    @new_delivery = Delivery.new

  end

  # GET /offers/1
  # GET /offers/1.json
  def show
    @offer = Offer.find(params[:id])
    @user = current_user
    @event = @offer.event
    @organizer = @offer.organizer
    @confirmation = @offer.client_confirmation

    @new_offer_box = OfferBox.new
    @offer_boxes = OfferBox.all
    @thisofferboxes = @offer_boxes.where(:offer_id => @offer.id)
    
    @new_offer_article = OfferArticle.new
    @offer_articles = OfferArticle.all
    @thisofferarticles = @offer_articles.where(:offer_id => @offer.id)

    @new_delivery = Delivery.new

    unless current_user.admin or current_user == @organizer
      redirect_to :back, :alert => t("notice.access")
    end
  end

  # GET /offers/new
  def new
    @offer = Offer.new
    unless current_user.admin
      redirect_to :back, :alert => t("notice.access")
    end
  end

  # GET /offers/1/edit
  def edit
    @offer = Offer.find(params[:id])
    @user = @offer.organizer
    @event = @offer.event
    unless current_user.admin
      redirect_to :back, :alert => t("notice.access")
    end
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)
    unless current_user.admin
      redirect_to :back, :alert => t("notice.access")
    end

    respond_to do |format|
      if @offer.save
        @offer.automatic
        format.html { redirect_to @offer, notice: 'Offer was successfully created.' }
        format.json { render :show, status: :created, location: @offer }
      else
        format.html { render :new }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offers/1
  # PATCH/PUT /offers/1.json
  def update
    @offer = Offer.find(params[:id])
    respond_to do |format|
      if @offer.update(offer_params)
        format.html { redirect_to @offer, notice: 'Offer was successfully updated.' }
        format.json { render :show, status: :ok, location: @offer }
      else
        format.html { render :edit }
        format.json { render json: @offer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offers/1
  # DELETE /offers/1.json
  def destroy
    @offer.destroy
    respond_to do |format|
      format.html { redirect_to offers_url, notice: 'Offer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer
      @offer = Offer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_params
      params.require(:offer).permit(:event_id, :organizer_id, :client_confirmation, :admin_confirmation)
    end
end
