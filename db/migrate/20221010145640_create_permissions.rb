class CreatePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :permissions do |t|
      t.string :uniqname, null: false
      t.string :role, null: false
      t.string :updated_by, null: false
      t.references :departments

      t.timestamps
    end
  end
end
