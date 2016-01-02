class User < ActiveRecord::Base
	has_many :events, :foreign_key => "creator_id"
	has_many :events, :foreign_key => "organizer_id"
	
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	def full_name
		"#{first_name} #{name}"
	end

end
