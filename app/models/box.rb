class Box < ActiveRecord::Base
	has_many :boxdetails
  has_many :offer_boxes
  has_many :return_details


	def automatic
      boxdetails.create(:box_id => id, :article_id => "11", :box_article_quantity => "1")
    if bigbox
      boxdetails.create(:box_id => id, :article_id => "9", :box_article_quantity => "1")
    elsif @box.smallbox
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
