class CreateAssets < ActiveRecord::Migration[7.0]
  def change
    create_table :assets do |t|
      t.references :appraisal_type, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.string :updated_by
      t.string :location_building
      t.string :location_room
      t.integer :value_cost
      t.datetime :date_acquired
      t.string :department_contact
      t.boolean :archived
      
      t.timestamps
    end
  end
end
