class BoxesController < ApplicationController
  before_action :set_box, only: [:show, :edit, :update, :destroy]

  # GET /boxes
  # GET /boxes.json
  def index
    @boxes = Box.all.order('box_name ASC')
    @user = current_user
    @closed_boxes = @boxes.where(:box_is_full => true)
    #@open_boxes = @boxes.where.not(:box_is_full => true)
    unless @user == current_user.staff or current_user.admin
      redirect_to :root, :alert => "Access denied."
    end
  end

  # GET /boxes/1
  # GET /boxes/1.json
  def show
    @user = current_user
    @box = Box.find(params[:id])
    @new_boxdetail = Boxdetail.new
    @boxdetails = Boxdetail.all
    @articles = Article.all
    @thisboxdetails = @boxdetails.where(:box_id => @box.id)
    unless @user == current_user.staff or current_user.admin
      redirect_to :root, :alert => "Access denied."
    end
  end

  # GET /boxes/new
  def new
    @box = Box.new
    @user = current_user
    unless @user == current_user.staff or current_user.admin
      redirect_to :root, :alert => "Access denied."
    end
  end

  # GET /boxes/1/edit
  def edit
    @user = current_user
    unless @user == current_user.staff or current_user.admin
      redirect_to :root, :alert => "Access denied."
    end
  end

  # POST /boxes
  # POST /boxes.json
  def create
    @box = Box.new(box_params)

    respond_to do |format|
      if @box.save

        @box.boxdetails.create(:box_id => @box.id, :article_id => "8", :box_article_quantity => "1")
        if @box.bigbox
          @box.boxdetails.create(:box_id => @box.id, :article_id => "4", :box_article_quantity => "1")
        elsif @box.smallbox
          @box.boxdetails.create(:box_id => @box.id, :article_id => "5", :box_article_quantity => "1")
        end
        
        format.html { redirect_to @box, notice: 'Box was successfully created.' }
        format.json { render :show, status: :created, location: @box }
      else
        format.html { render :new }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boxes/1
  # PATCH/PUT /boxes/1.json
  def update
    respond_to do |format|
      if @box.update(box_params)
        format.html { redirect_to @box, notice: 'Box was successfully updated.' }
        format.json { render :show, status: :ok, location: @box }
      else
        format.html { render :edit }
        format.json { render json: @box.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boxes/1
  # DELETE /boxes/1.json
  def destroy
    @box.destroy
    respond_to do |format|
      format.html { redirect_to boxes_url, notice: 'Box was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_box
      @box = Box.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def box_params
      params.require(:box).permit(:box_name, :box_regular, :box_type, :bigbox, :smallbox, :box_is_full)
    end
end
