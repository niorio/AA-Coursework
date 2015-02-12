class CreateBands < ActiveRecord::Migration
  def change
    create_table :bands do |t|
      t.string :name
      t.timestamps
    end

   add_column(:users, :created_at, :datetime)
   add_column(:users, :updated_at, :datetime)

  end
end
