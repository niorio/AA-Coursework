class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.integer :band_id
      t.string :style
    end

    add_index :albums, :band_id
  end
end
