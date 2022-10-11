class ChangeUpdatedByInAnnotation < ActiveRecord::Migration[7.0]
  def change
    remove_column :annotations, :updated_by
    add_reference :annotations, :user
  end
end
