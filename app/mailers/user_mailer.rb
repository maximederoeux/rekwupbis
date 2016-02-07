class UserMailer < ApplicationMailer

	def welcome_email(user, offer)
		@offer = offer
    @user = user
    @url  = 'http://localhost:3000/users/sign_in?locale=fr'
    mail(
    	to: @user.email, 
    	subject: 'Welcome to Rekwup')
  end

	def offer_email(user, offer)
		@offer = offer
    @organizer = user
    @url  = 'clients.rekwup.be/users/sign_in?locale=fr'
    mail(
    	to: @organizer.email, 
    	subject: I18n.t('mail.offer_title', :event_name => @offer.event.event_name)
      )
  end

  def deposit_email(user, offer, invoice)
    @offer = offer
    @invoice = invoice
    @organizer = user
    @url = 'clients.rekwup.be/invoice_url(@invoice)'

    mail(
      to: @organizer.email, 
      subject: I18n.t('mail.deposit_title', :pdf_name => @invoice.pdf_name)
      )
  end

end
