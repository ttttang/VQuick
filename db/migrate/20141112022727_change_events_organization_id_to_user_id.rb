class ChangeEventsOrganizationIdToUserId < ActiveRecord::Migration
  def change
  	remove_column :events, :organization_id
  	add_column :events, :user_id, :integer
  end
end
