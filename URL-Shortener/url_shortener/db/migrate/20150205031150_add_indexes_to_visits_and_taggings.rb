class AddIndexesToVisitsAndTaggings < ActiveRecord::Migration
  def change
    add_index(:visits, :short_url_id)
    add_index(:taggings, :tag_id)
    add_index(:taggings, :short_url_id)
  end
end
