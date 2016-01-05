class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      
      t.timestamps null: false
    end
  end
end
