class ChangeIntegerSizeToUser < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :cpf, :integer, limit: 8
  end
end
