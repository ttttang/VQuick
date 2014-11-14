class AddContactinfoToOrganizationsTable < ActiveRecord::Migration
  def change
  	add_column :organizations, :contact, :string
  end
end
