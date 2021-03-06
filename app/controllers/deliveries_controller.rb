class DeliveriesController < ApplicationController
  before_action :set_delivery, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /deliveries
  # GET /deliveries.json
  def index
    @deliveries = Delivery.order('delivery_date DESC').all
    @not_ready = Delivery.where(:is_ready => nil).where(:is_gone => nil).order('delivery_date DESC').all
    @not_gone = Delivery.where(:is_ready => true).where(:is_gone => nil).order('delivery_date DESC').all
    @gone = Delivery.where(:is_ready => true).where(:is_gone => true).order('delivery_date DESC').all
  end

  # GET /deliveries/1
  # GET /deliveries/1.json
  def show
    @delivery = Delivery.find(params[:id])

    @return_box = ReturnBox.new
    @return_detail = ReturnDetail.new
  end

  # GET /deliveries/new
  def new
    @delivery = Delivery.new
    @offer = @delivery.offer
    @user = current_user
    @admin = @user.admin
    unless @admin
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # GET /deliveries/1/edit
  def edit
    @user = current_user
    @delivery = Delivery.find(params[:id])
    @offer = @delivery.offer
    @organizer = @offer.organizer
    @admin = @user.admin
    @staff = @user.staff
    unless @admin or @organizer or @staff
      redirect_to :back, :alert => t("notice.access")
    end
  end

  # POST /deliveries
  # POST /deliveries.json
  def create
    @delivery = Delivery.new(delivery_params)
    @offer = @delivery.offer

    respond_to do |format|
      if @delivery.save
        @offer.update_attributes(:admin_confirmation => true)
        format.html { redirect_to @delivery, notice: 'Delivery was successfully created.' }
        format.json { render :show, status: :created, location: @delivery }
      else
        format.html { render :new }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deliveries/1
  # PATCH/PUT /deliveries/1.json
  def update
    respond_to do |format|
      if @delivery.update(delivery_params)
        if @delivery.is_gone && @delivery.dropped == nil && @delivery.other_cup == nil
          unless @delivery.offer.lln_daily
          ReturnBox.create(:offer_id => @delivery.offer_id, :return_date => @delivery.return_date)
          @delivery.offer.offer_boxes.each do |offer_box|
            ReturnDetail.create(:return_box_id => ReturnBox.last.id, :box_id => offer_box.box_id)
            # ReturnBox.last.return_details.build(params[:return_box_id => ReturnBox.last.id, :box_id => offer_box.box_id])
          end
          end
        end
        format.html { redirect_to deliveries_path, notice: 'Delivery was successfully updated.' }
        format.json { render :show, status: :ok, location: @delivery }
      else
        format.html { render :edit }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deliveries/1
  # DELETE /deliveries/1.json
  def destroy
    @delivery.offer.destroy
    @delivery.offer.offer_boxes.each do |offer_box|
      offer_box.destroy
    end
    @delivery.offer.offer_articles.each do |offer_article|
      offer_article.destroy
    end
    @delivery.offer.return_boxes.each do |return_box|
      return_box.destroy
    end
    @delivery.destroy
    respond_to do |format|
      format.html { redirect_to deliveries_url, notice: 'Delivery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery
      @delivery = Delivery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_params
      params.require(:delivery).permit(:other_cup, :offer_id, :delivery_date, :return_date, :is_ready, :is_gone, :ready_time, :ready_by, :gone_time, :sent_by, :dropped, :drop_time, :dropped_by)
    end
end
