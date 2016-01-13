class OfferArticlesController < ApplicationController
  before_action :set_offer_article, only: [:show, :edit, :update, :destroy]

  # GET /offer_articles
  # GET /offer_articles.json
  def index
    @offer_articles = OfferArticle.all
    @user = current_user
    @staff = @user.staff
    @admin = @user.admin
    unless @admin or @staff
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # GET /offer_articles/1
  # GET /offer_articles/1.json
  def show
  end

  # GET /offer_articles/new
  def new
    @offer_article = OfferArticle.new
    @user = current_user
    @admin = @user.admin
    unless @admin
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # GET /offer_articles/1/edit
  def edit
    @offer = @offer_article.offer
    @user = current_user
    @admin = @user.admin
    unless @admin
      redirect_to :root, :alert => t("notice.access")
    end
  end

  # POST /offer_articles
  # POST /offer_articles.json
  def create
    @offer_article = OfferArticle.new(offer_article_params)

    respond_to do |format|
      if @offer_article.save
        format.html { redirect_to :back, notice: 'Offer article was successfully created.' }
        format.json { render :show, status: :created, location: @offer_article }
      else
        format.html { render :new }
        format.json { render json: @offer_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /offer_articles/1
  # PATCH/PUT /offer_articles/1.json
  def update
    @offer = @offer_article.offer
    respond_to do |format|
      if @offer_article.update(offer_article_params)
        format.html { redirect_to @offer, notice: 'Offer article was successfully updated.' }
        format.json { render :show, status: :ok, location: @offer_article }
      else
        format.html { render :edit }
        format.json { render json: @offer_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offer_articles/1
  # DELETE /offer_articles/1.json
  def destroy
    @offer_article.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Offer article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_offer_article
      @offer_article = OfferArticle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def offer_article_params
      params.require(:offer_article).permit(:offer_id, :article_id, :quantity)
    end
end
