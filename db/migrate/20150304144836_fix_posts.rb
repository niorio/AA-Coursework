class FixPosts < ActiveRecord::Migration
  def change
    drop_table :posts
    create_table :posts do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end
