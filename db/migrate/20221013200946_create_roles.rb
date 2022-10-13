class CreateRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :roles do |t|
      t.string :name, null: false
      t.text :description
      t.references :user
      t.timestamps
    end
  end
end
