class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	belongs_to :organization
	has_many :attendances
	has_many :events, :through=> :attendances

	validates :fname, length: {minimum: 2}
	validates :lname, length: {minimum: 2}
	
	validate :admin_organization
	

	#Make sure admins select an organization
	def admin_organization
	    if admin && organization_id==nil
	    	errors.add(:organization_id, "Event organizers must select the organization they belong to.")
	    end
	end	

	

end
