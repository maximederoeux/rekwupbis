class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /offers
  # GET /offers.json
  def index
    @offers = Offer.all.order('id ASC')
    @events = Event.all
    @user = current_user

    @confirmedoffers = Offer.where(:client_confirmation => true)
    @rejectedoffers = Offer.where(:client_confirmation => false)
    @pendingoffers = Offer.where(:client_confirmation => nil)
    @confirmed_not_paid = @confirmedoffers.where(:confirmation_invoice => nil)
    @confirmed_paid = @confirmedoffers.where(:confirmation_invoice => true)
    @confirmed_not_sent = @confirmed_paid.where(:admin_confirmation => nil)
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
    @confirmation_invoice = @offer.confirmation_invoice

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
    @staff = @user.staff


    respond_to do |format|
      if @offer.save
        @offer.automatic

        if @offer.lln_daily && !@offer.unforeseen_return
          LlnImport.where(:id => @offer.organizer.lln_id).each do |import|

            if import.return_box >= 1
              ReturnBox.create(:offer_id => @offer.id, :return_date => Date.today + 1.day)
              @return_box = ReturnBox.last
              ReturnDetail.create(:return_box_id => @return_box.id, :box_id => Box.is_lln.is_twentyfive.first.id, :dirty => import.return_box)
            end
            if import.total_delivery >= 1
              Delivery.create(:offer_id => @offer.id, :delivery_date => Date.today + 1.day, :return_date => Date.today + 1.day)

              if import.lln_twentyfive >= 1
                OfferBox.create(:offer_id => @offer.id, :box_id => Box.is_lln.is_twentyfive.first.id, :quantity => import.lln_twentyfive)
              end

              if import.lln_fifty >= 1
                OfferBox.create(:offer_id => @offer.id, :box_id => Box.is_lln.is_fifty.first.id, :quantity => import.lln_fifty)
              end

              if import.lln_litre >= 1
                OfferBox.create(:offer_id => @offer.id, :box_id => Box.is_lln.is_litre.first.id, :quantity => import.lln_litre)
              end

              if import.empty_box >= 1
                OfferBox.create(:offer_id => @offer.id, :box_id => Box.is_empty.first.id, :quantity => import.empty_box)
              end

              if import.kpt_box >= 1
                OfferBox.create(:offer_id => @offer.id, :box_id => Box.is_lln.is_twentyfive.is_kpt.first.id, :quantity => import.kpt_box)
              end
            end

          end
        end

        if @offer.unforeseen_return
          ReturnBox.create(:offer_id => @offer.id, :return_date => Date.today)
          @return_box = ReturnBox.last
        end
        
          format.html { redirect_to :back, notice: 'Offer was successfully created.' }
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
        if @offer.confirmation_invoice
          Invoice.create(:offer_id => @offer.id, :client_id => @offer.organizer.id, :doc_invoice => true, :confirmation => true)
          @invoice = Invoice.last
          @invoice.update_attributes(:doc_number => @invoice.invoice_number, :total_htva => @invoice.total_htva_deposit, :total_tva => @invoice.total_tva_deposit, :total_tvac => @invoice.total_tvac_deposit)
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
    @offer.offer_boxes.each do |offer_box|
      offer_box.destroy
    end
    @offer.offer_articles.each do |offer_article|
      offer_article.destroy
    end
    @offer.return_boxes.each do |return_box|
      return_box.destroy
    end
    @offer.delivery.destroy
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
      params.require(:offer).permit(:event_id, :organizer_id, :client_confirmation, :admin_confirmation, :send_email, :lln_daily, :unforeseen_return, :lln_invoice, :confirmation_invoice, :comment)
    end
end
