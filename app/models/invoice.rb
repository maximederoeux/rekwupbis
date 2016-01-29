class Invoice < ActiveRecord::Base
		belongs_to :client, :class_name => "User"
		belongs_to :offer
end
