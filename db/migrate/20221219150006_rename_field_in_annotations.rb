class RenameFieldInAnnotations < ActiveRecord::Migration[7.0]
  def change
    rename_column :annotations, :created_by, :updated_by
  end
end
