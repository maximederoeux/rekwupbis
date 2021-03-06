class SortingDetailsController < ApplicationController
  before_action :set_sorting_detail, only: [:show, :edit, :update, :destroy]

  # GET /sorting_details
  # GET /sorting_details.json
  def index
    @sorting_details = SortingDetail.all
    @sortings = Sorting.all
    @february = @sortings.february.all.order('start_time')
    @march = @sortings.march.all.order('start_time')

    @cctwenty = Article.find(1)
    @cctwentyfive = Article.find(2)
    @ccforty = Article.find(3)
    @ccfifty = Article.find(4)
    @cclitre = Article.find(5)
    @llntwentyfive = Article.find(6)
    @llnfifty = Article.find(7)
    @llnlitre = Article.find(8)
    @eptwentyfive = Article.find(14)
    @epfifty = Article.find(29)
    @xdtwentyfive = Article.find(20)
    @cava = Article.find(22)
    @champagne = Article.find(31)
    @vinii = Article.find(24)
    @bs = Article.find(49)
    @bcc = Article.find(9)
    @bep = Article.find(12)
    @beplanet = Article.find(13)
    @diable = Article.find(15)
    @patro = Article.find(21)
  end

  # GET /sorting_details/1
  # GET /sorting_details/1.json
  def show
  end

  # GET /sorting_details/new
  def new
    @sorting_detail = SortingDetail.new
  end

  # GET /sorting_details/1/edit
  def edit
  end

  # POST /sorting_details
  # POST /sorting_details.json
  def create
    @sorting_detail = SortingDetail.new(sorting_detail_params)

    respond_to do |format|
      if @sorting_detail.save
        format.html { redirect_to :back, notice: 'Sorting detail was successfully created.' }
        format.json { render :show, status: :created, location: @sorting_detail }
      else
        format.html { render :new }
        format.json { render json: @sorting_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sorting_details/1
  # PATCH/PUT /sorting_details/1.json
  def update
    respond_to do |format|
      if @sorting_detail.update(sorting_detail_params)
        format.html { redirect_to :back, notice: 'Sorting detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @sorting_detail }
      else
        format.html { render :edit }
        format.json { render json: @sorting_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sorting_details/1
  # DELETE /sorting_details/1.json
  def destroy
    @sorting_detail.destroy
    respond_to do |format|
      format.html { redirect_to sorting_details_url, notice: 'Sorting detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sorting_detail
      @sorting_detail = SortingDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sorting_detail_params
      params.require(:sorting_detail).permit(:sorting_id, :article_id, :box_qtty, :pile_qtty, :unit_qtty, :clean, :very_dirty, :broken, :handling)
    end
end
