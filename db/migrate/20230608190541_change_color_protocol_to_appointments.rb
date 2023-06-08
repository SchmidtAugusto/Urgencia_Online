class ChangeColorProtocolToAppointments < ActiveRecord::Migration[7.0]
  def change
    change_column :appointments, :color_protocol, :string
  end
end
