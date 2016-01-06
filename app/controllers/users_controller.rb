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
    unless @user == current_user or current_user.admin
      redirect_to :back, :alert => "Access denied."
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Votre profil a bien été mis à jour.' }
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
      params.require(:user).permit(:name, :first_name, :individual, :company, :non_profit, :institution, :admin, :staff, :client, :company_name, :party, :dinner)
    end


end
