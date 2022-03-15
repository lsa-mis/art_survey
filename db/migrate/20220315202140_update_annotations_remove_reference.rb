class UpdateAnnotationsRemoveReference < ActiveRecord::Migration[7.0]
  def change
    remove_reference :annotations, :user, foreign_key: true, index: false
    add_column :annotations, :updated_by, :string, null: false
  end
end
