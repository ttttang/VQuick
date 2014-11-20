class AddAddressToEventsColumn < ActiveRecord::Migration
  def change
  	add_column :events, :street, :string
  	add_column :events, :city_state, :string
  	add_column :events, :zip, :string
  end
end
