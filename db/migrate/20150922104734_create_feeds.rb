class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer :user_id
      t.string :file

      t.timestamps null: false
    end
  end
end
