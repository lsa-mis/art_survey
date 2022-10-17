class RemoveArchivedFromArtItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :art_items, :archived, :binary
  end
end
