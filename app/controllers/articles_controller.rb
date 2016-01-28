class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all.order('article_name ASC')
    @user = current_user
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])
    @user = current_user
    @new_price = Price.new
    @prices = Price.all
    @regular_prices = @prices.where(:regular => true)
    @myregular_price = @regular_prices.where(:article_id => @article.id).last
  end

  # GET /articles/new
  def new
    @article = Article.new
    @user = current_user
    unless current_user.admin
      redirect_to :back, :alert => t("notice.access")
    end
  end

  # GET /articles/1/edit
  def edit
    @user = current_user
    unless current_user.admin
      redirect_to :back, :alert => t("notice.access")
    end
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: t("notice.article_created") }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: t("notice.article_updated") }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: t("notice.article_destroyed") }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:article_name, :article_content, :article_type, :article_category, :quantity_bigbox, :quantity_smallbox, :quantity_pile, :washing_price, :handwash_price, :tab_price, :deposit_price, :is_washable, :rekwup_cup, :sell_price, :weight, :is_cup)
    end
end
