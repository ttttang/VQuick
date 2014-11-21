class Event < ActiveRecord::Base
	has_many :attendances
	has_many :users, :through=> :attendances
	belongs_to :organization

	validates :name, presence: true
	validates :date_and_time, presence: true
	validates :hours, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than: 12}
	validates :minutes, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than: 59}
	validate :date_is_in_past
	validates :category, presence: true
	validates :street, presence: true
	validates :city_state, presence: true

	#for images
	has_attached_file :image, :styles => { :medium => "300x300>" }
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

#Makes sure newly created event is in the future
def date_is_in_past
    if date_and_time.present? && date_and_time < Time.now.in_time_zone("Pacific Time (US & Canada)")
    	errors.add(:date_and_time, "can't be in the past")
    end
end	

#Search bar searches these categories
def self.search(search)
  if search
  	where('name LIKE ? OR description LIKE ? OR requirements LIKE ?', "%#{search}%","%#{search}%","%#{search}%")
  else
    all
  end
end

def to_s
	"#{name}"
end
end
