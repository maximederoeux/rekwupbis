class ReturnBoxesController < ApplicationController
  before_action :set_return_box, only: [:show, :edit, :update, :destroy]

  # GET /return_boxes
  # GET /return_boxes.json
  def index
    @return_boxes = ReturnBox.all

    @not_back = ReturnBox.where(:is_back => nil).where(:is_controlled => nil)
    @not_controlled = ReturnBox.where(:is_back => true).where(:is_controlled => nil)
    @controlled = ReturnBox.where(:is_back => true).where(:is_controlled => true)
  end

  # GET /return_boxes/1
  # GET /return_boxes/1.json
  def show
    @return_box = ReturnBox.find(params[:id])
    @return_detail = ReturnDetail.new
    @return_details = ReturnDetail.all
    @boxes = Box.all
    @thisreturndetails = @return_details.where(:return_box_id => @return_box.id)
  end

  # GET /return_boxes/new
  def new
    @return_box = ReturnBox.new
  end

  # GET /return_boxes/1/edit
  def edit
  end

  # POST /return_boxes
  # POST /return_boxes.json
  def create
    @return_box = ReturnBox.new(return_box_params)
    @delivery = @return_box.delivery

    respond_to do |format|
      if @return_box.save
        #@return_box.automatic
       
        
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
    respond_to do |format|
      if @return_box.update(return_box_params)
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
      params.require(:return_box).permit(:delivery_id, :return_time, :is_back, :receptionist, :ctrl_time, :ctrler, :is_controlled, :return_date)
    end
end
