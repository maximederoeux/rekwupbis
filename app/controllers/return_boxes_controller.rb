class ReturnBoxesController < ApplicationController
  before_action :set_return_box, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /return_boxes
  # GET /return_boxes.json
  def index
    @return_boxes = ReturnBox.all

    @not_back = ReturnBox.where(:is_back => nil).where(:is_controlled => nil)
    @not_controlled = ReturnBox.where(:is_back => true).where(:is_controlled => nil)
    @controlled = ReturnBox.where(:is_back => true).where(:is_controlled => true)

    @user = current_user
    @staff = @user.staff
    @admin = @user.admin
    unless @admin or @staff
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # GET /return_boxes/1
  # GET /return_boxes/1.json
  def show
    @return_box = ReturnBox.find(params[:id])
    @return_detail = ReturnDetail.new
    @return_details = ReturnDetail.all
    @boxes = Box.all
    @thisreturndetails = @return_details.where(:return_box_id => @return_box.id)

    @user = current_user
    @staff = @user.staff
    @admin = @user.admin
    unless @admin or @staff
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # GET /return_boxes/new
  def new
    @return_box = ReturnBox.new

    @user = current_user
    @admin = @user.admin
    unless @admin
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # GET /return_boxes/1/edit
  def edit
    @user = current_user
    @staff = @user.staff
    @admin = @user.admin
    unless @admin or @staff
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # POST /return_boxes
  # POST /return_boxes.json
  def create
    @return_box = ReturnBox.new(return_box_params)
    @delivery = @return_box.delivery

    respond_to do |format|
      if @return_box.save   
        format.html { redirect_to @return_box, notice: 'Return box was successfully created.' }
        format.json { render :show, status: :created, location: @return_box }
      else
        format.html { render :new }
        format.json { render json: @return_box.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /return_boxes/1
  # PATCH/PUT /return_boxes/1.json
  def update
    @return_box = ReturnBox.find(params[:id])
    respond_to do |format|
      if @return_box.update(return_box_params)
        if @return_box.is_back && @return_box.is_controlled
          Wash.create(:return_box_id => @return_box.id)
          Sorting.create(:return_box_id => @return_box.id)
          @return_box.delivery.offer.offer_boxes.each do |offer_box|
            offer_box.box.boxdetails.each do |boxdetail|
              if boxdetail.article.is_cup
              SortingDetail.create(:sorting_id => Sorting.last.id, :article_id => boxdetail.article.id, :clean => true)
              end
            end
          end
          if @return_box.send_wash
            @return_box.return_details.where("clean > ?", 0).each do |detail|
            Parcel.create(:return_box_id => @return_box.id, :box_id => detail.box_id, :quantity => detail.clean, :from_return => true)
            end
          end
        end
        format.html { redirect_to @return_box, notice: 'Return box was successfully updated.' }
        format.json { render :show, status: :ok, location: @return_box }
      else
        format.html { render :edit }
        format.json { render json: @return_box.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /return_boxes/1
  # DELETE /return_boxes/1.json
  def destroy
    @return_box.destroy
    respond_to do |format|
      format.html { redirect_to return_boxes_url, notice: 'Return box was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_return_box
      @return_box = ReturnBox.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def return_box_params
      params.require(:return_box).permit(:delivery_id, :return_time, :is_back, :receptionist, :ctrl_time, :ctrler, :is_controlled, :return_date, :send_wash, return_details_attributes: [:box_id, :dirty, :sealed, :clean, :dirty_ctrl, :sealed_ctrl, :clean_ctrl])
    end
end
