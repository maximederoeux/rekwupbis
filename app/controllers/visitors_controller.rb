class VisitorsController < ApplicationController


  def index
    @users = User.all
    @user = current_user
    @articles = Article.all
    @rekwup_cups = @articles.where(:rekwup_cup => true)
    @attendance = current_user.attendances.last if user_signed_in?
    @new_attendance = Attendance.new
  end
  

end
