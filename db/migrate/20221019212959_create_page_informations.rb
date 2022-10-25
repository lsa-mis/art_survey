class CreatePageInformations < ActiveRecord::Migration[7.0]
  def change
    create_table :page_informations do |t|
      t.string :location, null: false

      t.timestamps
    end
  end
end
