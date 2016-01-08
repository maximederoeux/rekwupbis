class NegociatedPricesController < ApplicationController
  before_action :set_negociated_price, only: [:show, :edit, :update, :destroy]

  # GET /negociated_prices
  # GET /negociated_prices.json
  def index
    @negociated_prices = NegociatedPrice.all
    @users = User.all
    @clients = @users.where(:client => true).order('name ASC')
    @contracted = @clients.where(:negociated_price => true).order('name ASC')
    unless @user == current_user.admin
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # GET /negociated_prices/1
  # GET /negociated_prices/1.json
  def show
    @user = current_user
    unless @user == current_user.admin
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # GET /negociated_prices/new
  def new
    @negociated_price = NegociatedPrice.new
    @users = User.all
    @clients = @users.where(:client => true).order('name ASC')
    @contracted = @clients.where(:negociated_price => true).order('name ASC')
    @articles = Article.all.order('article_name ASC')
    @user = current_user
    unless @user == current_user.admin
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # GET /negociated_prices/1/edit
  def edit
    @user = current_user
    unless @user == current_user.admin
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # POST /negociated_prices
  # POST /negociated_prices.json
  def create
    @negociated_price = NegociatedPrice.new(negociated_price_params)

    respond_to do |format|
      if @negociated_price.save
        format.html { redirect_to :back, notice: 'Negociated price was successfully created.' }
        format.json { render :show, status: :created, location: @negociated_price }
      else
        format.html { render :new }
        format.json { render json: @negociated_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /negociated_prices/1
  # PATCH/PUT /negociated_prices/1.json
  def update
    respond_to do |format|
      if @negociated_price.update(negociated_price_params)
        format.html { redirect_to @negociated_price, notice: 'Negociated price was successfully updated.' }
        format.json { render :show, status: :ok, location: @negociated_price }
      else
        format.html { render :edit }
        format.json { render json: @negociated_price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /negociated_prices/1
  # DELETE /negociated_prices/1.json
  def destroy
    @negociated_price.destroy
    respond_to do |format|
      format.html { redirect_to negociated_prices_url, notice: 'Negociated price was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_negociated_price
      @negociated_price = NegociatedPrice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def negociated_price_params
      params.require(:negociated_price).permit(:article_id, :client_id, :washing_price, :handwash_price, :tab_price, :deposit_price)
    end
end
