class CreateAppointments < ActiveRecord::Migration[7.0]
  def change
    create_table :appointments do |t|
      t.references :user, null: false, foreign_key: true
      t.string :description
      t.integer :color_protocol
      t.references :hospital, null: false, foreign_key: true
      t.boolean :done, default: false
      t.integer :position

      t.timestamps
    end
  end
end
