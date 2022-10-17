class RemoveUniqnameFromPermissions < ActiveRecord::Migration[7.0]
  def change
    remove_column :permissions, :uniqname, :string
  end
end
