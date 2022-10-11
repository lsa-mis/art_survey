class RemoveDescriptionFromArtItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :art_items, :description
  end
end
