class CreateAnnotations < ActiveRecord::Migration[7.0]
  def change
    create_table :annotations do |t|
      t.string :uri, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
