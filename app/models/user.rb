class User < ActiveRecord::Base
	has_many :events, :foreign_key => "creator_id"
	has_many :events, :foreign_key => "organizer_id"
	has_many :negociated_prices, :foreign_key => "client_id"
	has_many :offers, :foreign_key => "organizer_id"

	has_many :deliveries, through: :offers
	has_many :sorting_details, through: :offers
	has_many :offer_articles, through: :offers

	has_many :prices

	has_many :invoices

	has_many :attendances
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


	scope :client, lambda {where(:client => true)}
	scope :staff, lambda {where(:staff => true)}
	scope :admin, lambda {where(:admin => true)}
	scope :interim, lambda {where(:staff => true) && where(:interim => true)}
	scope :fixed, lambda {where(:staff => true) && where(:fixed => true)}
	scope :leader, lambda {where(:staff => true) && where(:leader => true)}
	scope :time_keeping, lambda {where(:staff => true) && where(:time_keeping => true)}
	scope :chauffeur, lambda {where(:chauffeur => true)}
	scope :is_lln, lambda {where(:is_lln => true)}
	scope :is_namur, lambda {where(:is_namur => true)}

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

	def not_lln
		if is_lln == false
			true
		elsif is_lln == nil
			true
		end
	end

end
