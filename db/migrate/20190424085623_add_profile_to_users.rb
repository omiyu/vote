class AddProfileToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :account_name, :string
    add_column :users, :sex, :integer
    add_column :users, :age, :integer
    add_column :users, :profession, :string
    add_column :users, :address_pref, :string
    add_column :users, :annual_income, :integer
    add_column :users, :children, :integer
  end
end
