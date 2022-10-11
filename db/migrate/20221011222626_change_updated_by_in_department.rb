class ChangeUpdatedByInDepartment < ActiveRecord::Migration[7.0]
  def change
    remove_column :departments, :updated_by
    add_reference :departments, :user
  end
end
