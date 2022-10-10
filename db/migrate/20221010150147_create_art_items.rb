class CreateArtItems < ActiveRecord::Migration[7.0]
  def change
    create_table :art_items do |t|
      t.string :description, null: false
      t.string :location_building, null: false
      t.string :location_room
      t.integer :value_cost
      t.date :date_acquired
      t.references :appraisal_types
      t.boolean :archived, default: false, null: false
      t.belongs_to :departments
      t.string :updated_by, null: false

      t.timestamps
    end
  end
end
