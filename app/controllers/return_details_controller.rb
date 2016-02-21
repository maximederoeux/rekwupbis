class ReturnDetailsController < ApplicationController
  before_action :set_return_detail, only: [:show, :edit, :update, :destroy]

  # GET /return_details
  # GET /return_details.json
  def index
    @return_details = ReturnDetail.all
    @user = current_user
    @staff = @user.staff
    @admin = @user.admin
    unless @admin or @staff
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # GET /return_details/1
  # GET /return_details/1.json
  def show
  end

  # GET /return_details/new
  def new
    @return_detail = ReturnDetail.new

    @user = current_user
    @staff = @user.staff
    @admin = @user.admin
    unless @admin or @staff
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # GET /return_details/1/edit
  def edit
    @return_detail = ReturnDetail.find(params[:id])
    @return_box = @return_detail.return_box
    @new_return_detail = ReturnDetail.new
    @user = current_user
    @staff = @user.staff
    @admin = @user.admin
    unless @admin or @staff
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # POST /return_details
  # POST /return_details.json
  def create
    @return_detail = ReturnDetail.new(return_detail_params)

    respond_to do |format|
      if @return_detail.save
        format.html { redirect_to :back, notice: 'Return detail was successfully created.' }
        format.json { render :show, status: :created, location: @return_detail }
      else
        format.html { render :new }
        format.json { render json: @return_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /return_details/1
  # PATCH/PUT /return_details/1.json
  def update
    respond_to do |format|
      if @return_detail.update(return_detail_params)
        format.html { redirect_to :back, notice: 'Return detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @return_detail }
      else
        format.html { render :edit }
        format.json { render json: @return_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /return_details/1
  # DELETE /return_details/1.json
  def destroy
    @return_detail.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Return detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_return_detail
      @return_detail = ReturnDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def return_detail_params
      params.require(:return_detail).permit(:return_box_id, :box_id, :dirty, :sealed, :clean, :dirty_ctrl, :sealed_ctrl, :clean_ctrl, :missing_top, :tagged_top, :tagged_box, :missing_top_ctrl, :tagged_top_ctrl, :tagged_box_ctrl)
    end
end
