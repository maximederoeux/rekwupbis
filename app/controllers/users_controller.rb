class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @user = current_user
    @admin = @users.where(:admin => true)
    @staff = @users.where(:staff => true)
    @client = @users.where(:client => true)
    @individual = @users.where(:individual => true)
    @company = @users.where(:company => true)
    @non_profit = @users.where(:non_profit => true)
    @institution = @users.where(:institution => true)
  end

  def show
    @user = User.find(params[:id])
    @articles = Article.all
    @negociated_prices = NegociatedPrice.all
    unless @user == current_user or current_user.admin
      redirect_to :back, :alert => t("notice.access")
    end
  end

  def edit
    @user = User.find(params[:id])
    @negociated_price = NegociatedPrice.new
    @negociated_prices = NegociatedPrice.all
    @thisuserprices = @negociated_prices.where(:client_id => @user.id)
    unless @user == current_user or current_user.admin
      redirect_to :back, :alert => t("notice.access")
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        if current_user.admin
        format.html { redirect_to edit_user_path(@user), notice: t("notice.profile_updated")}
        else
        format.html { redirect_to @user, notice: t("notice.profile_updated")}
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
   
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :first_name, :individual, :company, :non_profit, :institution, :admin, :staff, :client, :company_name, :party, :dinner, :negociated_price)
    end


end
