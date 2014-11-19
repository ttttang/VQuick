class Organization < ActiveRecord::Base
	has_many :users
	has_many :events

	validates :name, presence: true
	validates :website, presence: true
	validates :email, presence: true
	def to_s
		"#{name}"
	end


	#Search bar categories
	def self.search(search)
	 
	  if search
	    where('name LIKE ?', "%#{search}%")
	  else
	    all
	  end
	end

end

