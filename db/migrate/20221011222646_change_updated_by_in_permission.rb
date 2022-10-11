class ChangeUpdatedByInPermission < ActiveRecord::Migration[7.0]
  def change
    remove_column :permissions, :updated_by
    add_reference :permissions, :user
  end
end
