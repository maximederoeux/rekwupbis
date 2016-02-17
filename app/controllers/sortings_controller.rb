class SortingsController < ApplicationController
  before_action :set_sorting, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /sortings
  # GET /sortings.json
  def index
    @sortings = Sorting.all
    @new_sorting = Sorting.new
    @to_start = Sorting.where(:start_time => nil).where(:end_time => nil)
    @started = Sorting.where.not(:start_time => nil).where(:end_time => nil)
    @finished = Sorting.where.not(:start_time => nil).where.not(:end_time => nil)
  end

  # GET /sortings/1
  # GET /sortings/1.json
  def show
    @sorting = Sorting.find(params[:id])
    @articles = @sorting.articles
    @new_sorting = Sorting.new
    @new_sorting_detail = SortingDetail.new
    @sorting_cups = @sorting.sorting_details
    @cleans = @sorting_cups.where(:clean => true)
    @brokens = @sorting_cups.where(:broken => true)
    @very_dirtys = @sorting_cups.where(:very_dirty => true)
    @handlings = @sorting_cups.where(:handling => true)
    @offer_boxes = @sorting.offer.offer_boxes
  end

  # GET /sortings/new
  def new
    @sorting = Sorting.new
  end

  # GET /sortings/1/edit
  def edit
  end

  # POST /sortings
  # POST /sortings.json
  def create
    @sorting = Sorting.new(sorting_params)

    respond_to do |format|
      if @sorting.save
        format.html { redirect_to @sorting, notice: 'Sorting was successfully created.' }
        format.json { render :show, status: :created, location: @sorting }
      else
        format.html { render :new }
        format.json { render json: @sorting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sortings/1
  # PATCH/PUT /sortings/1.json
  def update
    respond_to do |format|
      if @sorting.update(sorting_params)
        if @sorting.end_time.present?
          @sorting.sorting_details.where(:clean == true).each do |detail|
            if detail.box_qtty.present? && detail.box_qtty >= 0
            Parcel.create(:return_box_id => @sorting.return_box_id, :box_id => detail.article_id, :quantity => detail.box_qtty, :from_wash => true)
            end
          end
        end
        format.html { redirect_to @sorting, notice: 'Sorting was successfully updated.' }
        format.json { render :show, status: :ok, location: @sorting }
      else
        format.html { render :edit }
        format.json { render json: @sorting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sortings/1
  # DELETE /sortings/1.json
  def destroy
    @sorting.destroy
    respond_to do |format|
      format.html { redirect_to sortings_url, notice: 'Sorting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sorting
      @sorting = Sorting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sorting_params
      params.require(:sorting).permit(:offer_id, :return_box_id, :start_time, :end_time, :starter, :ender)
    end
end
