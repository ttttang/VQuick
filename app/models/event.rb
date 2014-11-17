class Event < ActiveRecord::Base
	has_many :attendances
	has_many :users, :through=> :attendances
	belongs_to :organization

	validates :name, presence: true
	validates :date_and_time, presence: true
	validates :hours, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than: 8}
	validates :minutes, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than: 59}
	validate :date_is_in_past

def date_is_in_past
    if date_and_time.present? && date_and_time < Time.now
    	errors.add(:date_and_time, "can't be in the past")
    end
end	

def to_s
	"#{name}"
end
end
