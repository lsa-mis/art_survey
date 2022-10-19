class CreateArtItems < ActiveRecord::Migration[7.0]
  def change
    create_table :art_items do |t|
      t.string :location_building, null: false
      t.string :location_room, null: false
      t.integer :value_cost, null: false
      t.date :date_acquired
      t.references :appraisal_type, null: false, foreign_key: true
      t.binary :archived, default: 0, null: false
      t.references :department, null: false, foreign_key: true
      t.integer :updated_by
      t.string :department_contact

      t.timestamps
    end
  end
end
