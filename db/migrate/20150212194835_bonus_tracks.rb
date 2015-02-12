class BonusTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :bonus, :boolean
  end
end
