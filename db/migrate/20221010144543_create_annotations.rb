class CreateAnnotations < ActiveRecord::Migration[7.0]
  def change
    create_table :annotations do |t|
      t.string :uri
      t.string :updated_by, null: false

      t.timestamps
    end
  end
end
