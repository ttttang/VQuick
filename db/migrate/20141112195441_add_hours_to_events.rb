class AddHoursToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :hours, :integer
  end
end
