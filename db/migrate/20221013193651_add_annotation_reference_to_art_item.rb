class AddAnnotationReferenceToArtItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :annotations, :art_item
  end
end
