class CreateAccesses < ActiveRecord::Migration[7.0]
  def change
    create_table :accesses do |t|
      t.references :permission, null: false, foreign_key: true
      t.string :uniqname
      t.integer :updated_by

      t.timestamps
    end
  end
end
