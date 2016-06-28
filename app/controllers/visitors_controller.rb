class VisitorsController < ApplicationController


  def index
    @users = User.all
    @staff = User.staff.order('name ASC')
    @events = Event.all.order('event_start_date ASC')
    @user = current_user
    @articles = Article.all
    @rekwup_cups = @articles.where(:rekwup_cup => true)
    @attendances = Attendance.all
    @new_attendance = Attendance.new
  end
  

end
