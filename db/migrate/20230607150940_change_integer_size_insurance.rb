class ChangeIntegerSizeInsurance < ActiveRecord::Migration[7.0]
  def change
    change_column :insurance_plans, :cns, :integer, limit: 8
    change_column :insurance_plans, :id_code, :integer, limit: 8
  end
end
