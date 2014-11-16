class Organization < ActiveRecord::Base
	has_many :users
	has_many :events

	

	def to_s
		"#{name}"
	end
end
