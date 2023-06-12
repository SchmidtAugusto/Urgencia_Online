class CreatePlanDetails < ActiveRecord::Migration[7.0]
  def change
    create_table :plan_details do |t|
      t.references :insurance_plan, null: false, foreign_key: true
      t.integer :product
      t.integer :id_code, limit: 8
      t.string :plan
      t.integer :cns, limit: 8
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
