class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :feed_id
      t.string :title
      t.string :url
      t.float :price

      t.timestamps null: false
    end
  end
end
