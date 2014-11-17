class RemoveAttendanceIdFromEvents < ActiveRecord::Migration
  def change
  	remove_column :events, :attendance_id
  end
end
