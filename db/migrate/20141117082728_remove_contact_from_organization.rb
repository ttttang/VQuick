class RemoveContactFromOrganization < ActiveRecord::Migration
  def change
  	remove_column :organizations, :contact
  end
end
