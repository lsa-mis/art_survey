class CreateAnnotations < ActiveRecord::Migration[7.0]
  def change
    create_table :annotations do |t|
      t.integer :created_by
      t.references :art_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
