class ChangeOwnerToUser < ActiveRecord::Migration
  def change
    rename_column :cats, :owner_id, :user_id
  end
end
