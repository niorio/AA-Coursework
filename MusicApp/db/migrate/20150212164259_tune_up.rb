class TuneUp < ActiveRecord::Migration
  def change

    add_column(:albums, :created_at, :datetime)
    add_column(:albums, :updated_at, :datetime)

    change_column :albums, :band_id, :integer, null: false
    change_column :albums, :title, :string, null: false
    change_column :bands, :name, :string, null: false

  end
end
