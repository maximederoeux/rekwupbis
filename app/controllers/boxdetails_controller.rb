class BoxdetailsController < ApplicationController
  before_action :set_boxdetail, only: [:show, :edit, :update, :destroy]

  # GET /boxdetails
  # GET /boxdetails.json
  def index
    @boxdetails = Boxdetail.all
    @user = current_user
  end

  # GET /boxdetails/1
  # GET /boxdetails/1.json
  def show
    @user = current_user
  end

  # GET /boxdetails/new
  def new
    @boxdetail = Boxdetail.new
    @box = Box.find(params[:id])
    @article = Article.all
    @user = current_user
  end

  # GET /boxdetails/1/edit
  def edit
    @user = current_user
  end

  # POST /boxdetails
  # POST /boxdetails.json
  def create
    @boxdetail = Boxdetail.new(boxdetail_params)


    respond_to do |format|
      if @boxdetail.save
        format.html { redirect_to :back, notice: 'Boxdetail was successfully created.' }
        format.json { render :show, status: :created, location: @boxdetail }
      else
        format.html { render :new }
        format.json { render json: @boxdetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boxdetails/1
  # PATCH/PUT /boxdetails/1.json
  def update
    respond_to do |format|
      if @boxdetail.update(boxdetail_params)
        format.html { redirect_to boxes_path, notice: 'Boxdetail was successfully updated.' }
        format.json { render :show, status: :ok, location: @boxdetail }
      else
        format.html { render :edit }
        format.json { render json: @boxdetail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boxdetails/1
  # DELETE /boxdetails/1.json
  def destroy
    @boxdetail.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Boxdetail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_boxdetail
      @boxdetail = Boxdetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def boxdetail_params
      params.require(:boxdetail).permit(:box_id, :article_id, :box_article_quantity)
    end
end
