class DeliveriesController < ApplicationController
  before_action :set_delivery, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /deliveries
  # GET /deliveries.json
  def index
    @deliveries = Delivery.all
    @not_ready = Delivery.where(:is_ready => nil).where(:is_gone => nil)
    @not_gone = Delivery.where(:is_ready => true).where(:is_gone => nil)
    @gone = Delivery.where(:is_ready => true).where(:is_gone => true)
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
        if @delivery.is_gone
          ReturnBox.create(:delivery_id => @delivery.id, :return_date => @delivery.return_date)
          @delivery.offer.offer_boxes.each do |offer_box|
            ReturnDetail.create(:return_box_id => ReturnBox.last.id, :box_id => offer_box.box_id)
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
      params.require(:delivery).permit(:offer_id, :delivery_date, :return_date, :is_ready, :is_gone, :ready_time, :ready_by, :gone_time, :sent_by)
    end
end
