class ReportingController < ApplicationController
  def attendances
  	@attendances = Attendance.all
  end

	def interim
		@attendances = Attendance.all
	end

  def invoices
    @invoices = Invoice.all
    
  end

	def interim_pdf
		@attendances = Attendance.all

    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "Semaine #{(Date.today - 6.days).strftime("%Y")} - #{(Date.today - 6.days).strftime("%W")}", :layout => 'layouts/pdf.html.erb', :template => 'reporting/interim_pdf.html.erb'
      end
    end
	end

  def statistics
  end
end
