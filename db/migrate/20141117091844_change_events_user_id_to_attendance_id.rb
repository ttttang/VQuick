class ChangeEventsUserIdToAttendanceId < ActiveRecord::Migration
  def change
  	remove_column :events, :user_id
  	add_column :events, :attendance_id, :integer
  end
end
