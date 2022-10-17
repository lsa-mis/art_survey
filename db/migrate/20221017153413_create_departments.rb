class CreateDepartments < ActiveRecord::Migration[7.0]
  def change
    create_table :departments do |t|
      t.integer :deptID, null: false
      t.string :fullname, null: false
      t.string :shortname
      t.integer :updated_by

      t.timestamps
    end

    add_index :departments, :deptID,                unique: true
  end
end
