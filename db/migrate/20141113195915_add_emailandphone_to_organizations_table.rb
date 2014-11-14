class AddEmailandphoneToOrganizationsTable < ActiveRecord::Migration
  def change
  	add_column :organizations, :phone, :string
  	add_column :organizations, :email, :string
  end
end
