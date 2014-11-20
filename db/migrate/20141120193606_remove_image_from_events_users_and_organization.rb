class RemoveImageFromEventsUsersAndOrganization < ActiveRecord::Migration
  def change
  	remove_column :users, :image 
  	remove_column :events, :image
  	remove_column :organizations, :image
  	
  end
end
