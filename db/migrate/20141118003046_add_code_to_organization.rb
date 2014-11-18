class AddCodeToOrganization < ActiveRecord::Migration
  def change
  	add_column :organizations, :code, :string
  end
end
