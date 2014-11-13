class Event < ActiveRecord::Base
	has_many :attendances
	has_many :users, :through=> :attendances
	belongs_to :organization

def to_s
	"#{name}"
end
end
