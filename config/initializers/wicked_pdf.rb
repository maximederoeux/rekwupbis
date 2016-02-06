# WickedPDF Global Configuration
#
# Use this to set up shared configuration options for your entire application.
# Any of the configuration options shown here can also be applied to single
# models by passing arguments to the `render :pdf` call.
#
# To learn more, check out the README:
#
# https://github.com/mileszs/wicked_pdf/blob/master/README.md

WickedPdf.config = {
	if Rails.env == 'production' then
    config.exe_path = Rails.root.to_s + "/bin/wkhtmltopdf"
  else
 :wkhtmltopdf => '/home/ferache/.rbenv/versions/2.2.3/bin/wkhtmltopdf',
  # Path to the wkhtmltopdf executable: This usually isn't needed if using
  # one of the wkhtmltopdf-binary family of gems.
  exe_path: '/home/ferache/.rbenv/versions/2.2.3/bin/wkhtmltopdf'
  #   or
  # exe_path: Gem.bin_path('wkhtmltopdf-binary', 'wkhtmltopdf')

  # Layout file to be used for all PDFs
  # (but can be overridden in `render :pdf` calls)
  # layout: 'pdf.html',
	end
}

# WickedPdf.config do |config|  
#   if Rails.env == 'production' then
#     config.exe_path = Rails.root.to_s + "/bin/wkhtmltopdf"
#   else  ### Following allows for development on my MacBook or Linux box
#     if /darwin/ =~ RUBY_PLATFORM then
#       config.exe_path = '/usr/local/bin/wkhtmltopdf' 
#     elsif /linux/ =~ RUBY_PLATFORM then
#       config.exe_path = '/usr/bin/wkhtmltopdf' 
#     else
#       raise "UnableToLocateWkhtmltopdf"
#     end
#   end
# end
