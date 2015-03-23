class AddIndexToCatOwners < ActiveRecord::Migration
  def change
    add_index :cats, :owner_id
  end
end
