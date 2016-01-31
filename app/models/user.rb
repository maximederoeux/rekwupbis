class User < ActiveRecord::Base
	has_many :events, :foreign_key => "creator_id"
	has_many :events, :foreign_key => "organizer_id"
	has_many :negociated_prices, :foreign_key => "client_id"
	has_many :offers, :foreign_key => "organizer_id"

	has_many :deliveries, through: :offers

	has_many :prices

	has_many :invoices
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


	scope :client, lambda {where(:client => true)}
	scope :is_lln, lambda {where(:is_lln => true)}
	scope :not_lln, lambda {where(:is_lln => nil)}

	def full_name
		"#{first_name} #{name}"
	end

	def full_name_with_company
		if company_name.present?
			"#{name} #{I18n.t('word.from')} #{company_name}"
		else
			"#{name}"
		end
	end

	def status_display
		if admin == true
			"Admin"

		elsif staff == true
			"Staff"

		elsif client == true
			"Client"
		end
	end

	def company_display
		if individual == true
			I18n.t('user.individual')
		elsif company == true
			I18n.t('user.company')
		elsif non_profit == true
			I18n.t('user.non_profit')
		elsif institution == true
			I18n.t('user.institution')
		end
	end

end
