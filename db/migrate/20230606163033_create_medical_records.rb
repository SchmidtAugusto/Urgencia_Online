class CreateMedicalRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :medical_records do |t|
      t.references :user, null: false, foreign_key: true
      t.string :blood_type
      t.string :allergies
      t.float :weight
      t.float :height
      t.string :health_conditions

      t.timestamps
    end
  end
end
