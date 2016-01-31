class Box < ActiveRecord::Base
	
  has_many :boxdetails
  has_many :articles, through: :boxdetails
  
  has_many :offer_boxes
  has_many :offers, through: :offer_boxes

  has_many :return_details

  has_many :parcels

  scope :closed, lambda {where(:box_is_full => true)}
  scope :twentyfive, lambda {where(:lln_twentyfive => true)}
  scope :fifty, lambda {where(:lln_fifty => true)}
  scope :litre, lambda {where(:lln_litre => true)}
  scope :empty_box, lambda {where(:empty_box => true)}
  scope :kpt_box, lambda {where(:kpt_box => true)}

	def automatic
      boxdetails.create(:box_id => id, :article_id => "11", :box_article_quantity => "1")
    if bigbox
      boxdetails.create(:box_id => id, :article_id => "9", :box_article_quantity => "1")
    elsif smallbox
      boxdetails.create(:box_id => id, :article_id => "10", :box_article_quantity => "1")
    end
	end

  def weight
    weight = 0
    self.boxdetails.each do |boxdetail|
    weight += boxdetail.weight
    end
    weight
  end

end
