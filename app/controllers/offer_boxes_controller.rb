class OfferBoxesController < ApplicationController
  before_action :set_offer_box, only: [:show, :edit, :update, :destroy]

  # GET /offer_boxes
  # GET /offer_boxes.json
  def index
    @offer_boxes = OfferBox.all
    @user = current_user
    @admin = @user.admin
    unless @admin
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # GET /offer_boxes/1
  # GET /offer_boxes/1.json
  def show
  end

  # GET /offer_boxes/new
  def new
    @offer_box = OfferBox.new
    @user = current_user
    @admin = @user.admin
    unless @admin
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # GET /offer_boxes/1/edit
  def edit
    @offer = @offer_box.offer
    @user = current_user
    @admin = @user.admin
    unless @admin
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # POST /offer_boxes
  # POST /offer_boxes.json
  def create
    @offer_box = OfferBox.new(offer_box_params)

    respond_to do |format|
      if @offer_box.save
        format.html { redirect_to :back, notice: 'Offer box was successfully created.' }
        format.json { render :show, status: :created, location: @offer_box }
      else
        format.html { render :new }
        format.json { render json: @offer_box.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offer_boxes/1
  # PATCH/PUT /offer_boxes/1.json
  def update
    @offer = @offer_box.offer

    respond_to do |format|
      if @offer_box.update(offer_box_params)
        format.html { redirect_to @offer, notice: 'Offer box was successfully updated.' }
        format.json { render :show, status: :ok, location: @offer_box }
      else
        format.html { render :edit }
        format.json { render json: @offer_box.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offer_boxes/1
  # DELETE /offer_boxes/1.json
  def destroy
    @offer = @offer_box.offer
    @offer_box.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Offer box was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer_box
      @offer_box = OfferBox.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_box_params
      params.require(:offer_box).permit(:offer_id, :box_id, :quantity)
    end
end
