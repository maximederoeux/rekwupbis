class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  # GET /offers
  # GET /offers.json
  def index
    @offers = Offer.all
    @events = Event.all
    @user = current_user
    @myoffers = Offer.where(:organizer => current_user)
    @confirmedoffers = Offer.where(:client_confirmation => true)
    @myconfirmedoffers = @myoffers.where(:client_confirmation => true)
    @mywaitingoffers = @myoffers.where(:client_confirmation => false)

  end

  # GET /offers/1
  # GET /offers/1.json
  def show
    @offer = Offer.find(params[:id])
    @event = @offer.event
    @organizer = @offer.organizer

    @new_offer_box = OfferBox.new
    @offer_boxes = OfferBox.all
    @thisofferboxes = @offer_boxes.where(:offer_id => @offer.id)
    
    @new_offer_article = OfferArticle.new
    @offer_articles = OfferArticle.all
    @thisofferarticles = @offer_articles.where(:offer_id => @offer.id)
  end

  # GET /offers/new
  def new
    @offer = Offer.new
  end

  # GET /offers/1/edit
  def edit
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)
    @event = @offer.event

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