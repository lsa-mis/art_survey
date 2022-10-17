class CreatePermissions < ActiveRecord::Migration[7.0]
  def change
    create_table :permissions do |t|
      t.string :uniqname, null: false
      t.references :role, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.integer :updated_by

      t.timestamps
    end
  end
end
