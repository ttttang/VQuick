class AddImageToEventUserAndOrganization < ActiveRecord::Migration
  def change
  	add_column :events, :image, :string
  	add_column :users, :image, :string
  	add_column :organizations, :image, :string
  end
end
