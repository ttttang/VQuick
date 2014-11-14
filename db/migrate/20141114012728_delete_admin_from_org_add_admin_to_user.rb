class DeleteAdminFromOrgAddAdminToUser < ActiveRecord::Migration
  def change
  	remove_column :organizations, :admin
  	add_column :users, :admin, :boolean
  end
end
