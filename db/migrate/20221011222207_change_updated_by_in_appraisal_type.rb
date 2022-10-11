class ChangeUpdatedByInAppraisalType < ActiveRecord::Migration[7.0]
  def change
    remove_column :appraisal_types, :updated_by
    add_reference :appraisal_types, :user
  end
end
