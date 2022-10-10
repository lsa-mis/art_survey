class CreateDepartments < ActiveRecord::Migration[7.0]
  def change
    create_table :departments do |t|
      t.integer :dept_number, null: false
      t.string :name, null: false
      t.string :short_name, null: false
      t.string :updated_by, null: false

      t.timestamps
    end
  end
end
