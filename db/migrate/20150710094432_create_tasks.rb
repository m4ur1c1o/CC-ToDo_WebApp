class CreateTasks < ActiveRecord::Migration
  def change
  	create_table :tasks do |t|
  		t.belongs_to :user
  		t.string :content
  		t.boolean :done, :default => false

    	t.timestamps
    end
  end
end
