class AddMinutesToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :minutes, :integer
  end
end
