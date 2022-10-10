class CreateAppraisalTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :appraisal_types do |t|
      t.string :name, null: false
      t.string :description
      t.string :updated_by, null: false

      t.timestamps
    end
  end
end
