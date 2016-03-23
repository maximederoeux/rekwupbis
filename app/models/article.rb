class Article < ActiveRecord::Base
	
	has_many :boxdetails
	has_many :boxes, through: :boxdetails

	has_many :prices
	has_many :offer_articles
	has_many :sorting_details

	scope :not_washable, lambda {where.not(:is_washable => true)}
	scope :washable, lambda {where(:is_washable => true)}
	scope :is_cup, lambda {where(:is_cup => true)}
	scope :is_rekwup, lambda {where(:rekwup_cup => true)}
	scope :is_lln, lambda {where(:is_lln => true)}
	scope :is_bep, lambda {where(:is_bep => true)}
	scope :is_patro, lambda {where(:is_patro => true)}
	scope :is_twenty, lambda {where(:is_twenty => true)}
	scope :is_twentyfive, lambda {where(:is_twentyfive => true)}
	scope :is_forty, lambda {where(:is_forty => true)}
	scope :is_fifty, lambda {where(:is_fifty => true)}
	scope :is_litre, lambda {where(:is_litre => true)}
	scope :is_cc, lambda {where(:is_cc => true)}
	scope :is_ep, lambda {where(:is_ep => true)}
	scope :is_eco, lambda {where(:is_eco => true)}
	scope :is_wine, lambda {where(:is_wine => true)}
	scope :is_cava, lambda {where(:is_cava => true)}
	scope :is_shot, lambda {where(:is_shot => true)}
	scope :is_transport, lambda {where(:transport => true)}
	scope :is_big_box, lambda {where(:is_big_box => true)}
	scope :is_small_box, lambda {where(:is_small_box => true)}
	scope :is_top, lambda {where(:is_top => true)}
	scope :is_palette, lambda {where(:is_palette => true)}
	scope :is_empty, lambda {where(:is_empty => true)}
	scope :is_corona, lambda {where(:is_corona => true)}


	def full_name
		"#{article_name}"
	end

	def cup_type
		if is_cc
			I18n.t("article.is_cc")
		elsif is_ep
			I18n.t("article.is_ep")
		elsif is_eco
			I18n.t("article.is_eco")
		elsif is_wine
			I18n.t("article.is_wine")
		elsif is_cava
			I18n.t("article.is_cava")
		elsif is_shot
			I18n.t("article.is_shot")
		elsif is_big_box
			I18n.t("article.is_big_box")
		elsif is_small_box
			I18n.t("article.is_small_box")
		elsif is_top
			I18n.t("article.is_top")
		elsif is_palette
			I18n.t("article.is_palette")
		elsif transport
			I18n.t("article.transport")
		end	
	end

	def cup_content
		if is_twenty
			I18n.t("article.is_twenty")
		elsif is_twentyfive
			I18n.t("article.is_twentyfive")
		elsif is_forty
			I18n.t("article.is_forty")
		elsif is_fifty
			I18n.t("article.is_fifty")
		elsif is_litre
			I18n.t("article.is_litre")
		end
	end

	def cup_owner
		if rekwup_cup
			I18n.t("article.rekwup_cup")
		elsif is_lln
			I18n.t("article.is_lln")
		elsif is_patro
			I18n.t("article.is_patro")
		elsif is_bep
			I18n.t("article.is_bep")
		end			
	end


	def box_value
		if quantity_bigbox.present?
			quantity_bigbox
		else
			0
		end		
	end

	def pile_value
		if quantity_pile.present?
			quantity_pile
		else
			0
		end
	end

	def has_price
		if self.prices.any?
			"#{self.prices.count} Prix"
		end
	end

	def right_wash_price(user)
		if user.negociated_price == true
			if Price.negociated.where(:article_id => id).where(:user_id => user.id).any?
				Price.negociated.where(:article_id => id).where(:user_id => user.id).last.washing_value
			else
				if Price.regular.where(:article_id => id).any?
					Price.regular.where(:article_id => id).last.washing_value
				else
					0
				end
			end
		else
			if Price.regular.where(:article_id => id).any?
				Price.regular.where(:article_id => id).last.washing_value
			else
				0
			end
		end

	end

	def right_washing_small_price(user)
		if user.negociated_price == true
			if Price.negociated.where(:article_id => id).where(:user_id => user.id).any?
				Price.negociated.where(:article_id => id).where(:user_id => user.id).last.washing_small_value
			else
				if Price.regular.where(:article_id => id).any?
					Price.regular.where(:article_id => id).last.washing_small_value
				else
					0
				end
			end
		else
			if Price.regular.where(:article_id => id).any?
				Price.regular.where(:article_id => id).last.washing_small_value
			else
				0
			end
		end

	end

	def right_handwash_price(user)
		if user.negociated_price == true
			if Price.negociated.where(:article_id => id).where(:user_id => user.id).any?
				Price.negociated.where(:article_id => id).where(:user_id => user.id).last.handwash_value
			else
				if Price.regular.where(:article_id => id).any?
					Price.regular.where(:article_id => id).last.handwash_value
				else
					0
				end
			end
		else
			if Price.regular.where(:article_id => id).any?
				Price.regular.where(:article_id => id).last.handwash_value
			else
				0
			end
		end
	end

	def right_handling_price(user)
		if user.negociated_price == true
			if Price.negociated.where(:article_id => id).where(:user_id => user.id).any?
				Price.negociated.where(:article_id => id).where(:user_id => user.id).last.handling_value
			else
				if Price.regular.where(:article_id => id).any?
					Price.regular.where(:article_id => id).last.handling_value
				else
					0
				end
			end
		else
			if Price.regular.where(:article_id => id).any?
				Price.regular.where(:article_id => id).last.handling_value
			else
				0
			end
		end
	end

	def right_deposit_price(user, event)
		if event.deposit_on_site.present?
			if event.deposit_on_site = 1
				if Price.regular.where(:article_id => id).any?
					Price.regular.where(:article_id => id).last.deposit_value
				else
					0.7
				end
			elsif event.deposit_on_site = 0
				if Price.regular.where(:article_id => id).any?
					Price.regular.where(:article_id => id).last.deposit_value
				else
					0
				end
			elsif event.deposit_on_site >= 1.0005
				event.deposit_on_site * 0.7
			else
				0
			end
		else
			if user.negociated_price == true
				if Price.negociated.where(:article_id => id).where(:user_id => user.id).any?
					Price.negociated.where(:article_id => id).where(:user_id => user.id).last.deposit_value
				else
					if Price.regular.where(:article_id => id).any?
						Price.regular.where(:article_id => id).last.deposit_value
					else
						0
					end
				end
			else
				if Price.regular.where(:article_id => id).any?
					Price.regular.where(:article_id => id).last.deposit_value
				else
					0
				end
			end
		end
	end

	def right_sell_price(user)
		if user.negociated_price == true
			if Price.negociated.where(:article_id => id).where(:user_id => user.id).any?
				Price.negociated.where(:article_id => id).where(:user_id => user.id).last.sell_value
			else
				if Price.regular.where(:article_id => id).any?
					Price.regular.where(:article_id => id).last.sell_value
				else
					0
				end
			end
		else
			if Price.regular.where(:article_id => id).any?
				Price.regular.where(:article_id => id).last.sell_value
			else
				0
			end
		end
	end

end
