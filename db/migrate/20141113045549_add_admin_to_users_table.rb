class AddAdminToUsersTable < ActiveRecord::Migration
  def change
  	add_column :organizations, :admin, :boolean
  end
end
