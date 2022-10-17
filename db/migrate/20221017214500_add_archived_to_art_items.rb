class AddArchivedToArtItems < ActiveRecord::Migration[7.0]
  def change
    add_column :art_items, :archived, :boolean, default: 0
  end
end
