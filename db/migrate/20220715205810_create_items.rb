class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :description
      t.string :location_building
      t.string :location_room
      t.integer :value_cost
      t.datetime :date_acquired
      t.string :department_contact
      t.string :updated_by
      t.boolean :archived
      t.references :appraisal_type, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
  end
end
