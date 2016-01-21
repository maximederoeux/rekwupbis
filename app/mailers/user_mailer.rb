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
    @url  = 'http://localhost:3000/users/sign_in?locale=fr'
    mail(
    	to: @organizer.email, 
    	subject: I18n.t('mail.offer_title', :event_name => @offer.event.event_name)
      )
  end

end
