class ReportingController < ApplicationController
  def attendances
  	@attendances = Attendance.all
  	@staffs = User.staff
  end

  def statistics
  end
end
