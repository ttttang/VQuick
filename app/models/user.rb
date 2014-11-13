class User < ActiveRecord::Base
	belongs_to :organization
	has_many :attendances
	has_many :events, :through=> :attendances
end
