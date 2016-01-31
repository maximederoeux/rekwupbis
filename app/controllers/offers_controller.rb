class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /offers
  # GET /offers.json
  def index
    @offers = Offer.all
    @events = Event.all
    @user = current_user

    @confirmedoffers = Offer.where(:client_confirmation => true)
    @rejectedoffers = Offer.where(:client_confirmation => false)
    @pendingoffers = Offer.where(:client_confirmation => nil)
    @confirmed_not_sent = @confirmedoffers.where(:admin_confirmation => nil)
    @confirmed = @confirmedoffers.where(:admin_confirmation => true)

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

    @articles = Article.all

    @new_offer_box = OfferBox.new
    @offer_boxes = OfferBox.all
    @thisofferboxes = @offer_boxes.where(:offer_id => @offer.id)
    
    @new_offer_article = OfferArticle.new
    @offer_articles = OfferArticle.all
    @thisofferarticles = @offer_articles.where(:offer_id => @offer.id)

    @prices = Price.all
    @regular_prices = @prices.where(:regular => true)
    @new_delivery = Delivery.new

    @admin = @user.admin
    unless @admin or @organizer
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # GET /offers/new
  def new
    @offer = Offer.new
    @user =current_user
    @admin = @user.admin
    unless @admin
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # GET /offers/1/edit
  def edit
    @offer = Offer.find(params[:id])
    @user = current_user
    @organizer = @offer.organizer
    @event = @offer.event
    @admin = @user.admin
    @staff = @user.staff
    unless @admin or @organizer or @staff
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # POST /offers
  # POST /offers.json
  def create
    @offer = Offer.new(offer_params)
    @user =current_user
    @admin = @user.admin
    unless @admin
      redirect_to :root, :alert => t("notice.access")
    end

    respond_to do |format|
      if @offer.save
        @offer.automatic
        if @offer.lln_daily
          Delivery.create(:offer_id => @offer.id, :delivery_date => Date.today + 1.day, :return_date => Date.today + 1.day)
          LlnImport.where(:id => @offer.organizer.lln_id).each do |import|

            if import.lln_twentyfive >= 1
              OfferBox.create(:offer_id => @offer.id, :box_id => Box.twentyfive.first.id, :quantity => import.lln_twentyfive)
            end

            if import.lln_fifty >= 1
              OfferBox.create(:offer_id => @offer.id, :box_id => Box.fifty.first.id, :quantity => import.lln_fifty)
            end

            if import.lln_litre >= 1
              OfferBox.create(:offer_id => @offer.id, :box_id => Box.litre.first.id, :quantity => import.lln_litre)
            end

            if import.return_box >= 1
              ReturnBox.create(:delivery_id => Delivery.where(:offer_id => @offer.id).last.id, :return_date => Date.today + 1.day)
              ReturnDetail.create(:return_box_id => ReturnBox.last.id, :box_id => Box.twentyfive.first.id)
            end

          end
        end
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
    @user = @offer.organizer
           
    respond_to do |format|
      if @offer.update(offer_params)
        if @offer.send_email
          UserMailer.offer_email(@user, @offer).deliver_later
          @offer.update_attributes(:send_email => false)
        end
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
      params.require(:offer).permit(:event_id, :organizer_id, :client_confirmation, :admin_confirmation, :send_email, :lln_daily)
    end
end
