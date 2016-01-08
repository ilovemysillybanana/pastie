class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :name
      t.text :code
      t.string :language

      t.timestamps null: false
    end
  end
end
