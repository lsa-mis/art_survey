class CreateAppraisalTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :appraisal_types do |t|
      t.string :classification
      t.text :description
      t.integer :updated_by

      t.timestamps
    end
  end
end
