class AddingJoiningTable < ActiveRecord::Migration
  def change
  	remove_column :events, :user_id
  	create_table :users_events, id: false do |t|
  		t.belongs_to :user
  		t.belongs_to :event
  	end
  end
end
