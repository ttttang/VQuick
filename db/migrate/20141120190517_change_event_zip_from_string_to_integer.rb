class ChangeEventZipFromStringToInteger < ActiveRecord::Migration
  def change
  	remove_column :events, :zip
  	add_column :events, :zip, :integer
  end
end
