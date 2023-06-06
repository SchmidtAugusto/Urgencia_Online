class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :cpf, :integer
    add_column :users, :birthdate, :date
    add_column :users, :address, :string
    add_column :users, :admin, :boolean, default: false
  end
end
