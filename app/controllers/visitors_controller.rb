class VisitorsController < ApplicationController


  def index
    @users = User.all
    @user = current_user
    @articles = Article.all
    @rekwup_cups = @articles.where(:rekwup_cup => true)
  end
  
end
