class Organization < ActiveRecord::Base
	has_many :users
	has_many :events

	validates :name, presence: true
	validates :name, uniqueness: { case_sensitive: false }
	validates :website, presence: true
	validates :website, uniqueness: { case_sensitive: false }
	validates :email, presence: true
	validates :email, uniqueness: { case_sensitive: false }
	
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

