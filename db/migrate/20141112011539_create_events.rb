class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.string :name
    	t.integer :user_id
    	t.date :date
    	t.time :time
    	t.string :description
    	t.string :requirements
      t.timestamps
    end
  end
end
