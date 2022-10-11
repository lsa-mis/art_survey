class ChangeUpdatedByInArtItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :art_items, :updated_by
    add_reference :art_items, :user
  end
end
