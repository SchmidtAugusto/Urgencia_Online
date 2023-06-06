class CreateInsurancePlans < ActiveRecord::Migration[7.0]
  def change
    create_table :insurance_plans do |t|
      t.string :name
      t.integer :product
      t.integer :id_code
      t.string :plan
      t.integer :cns
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
