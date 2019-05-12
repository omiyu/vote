class RemoveChildrenFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :children, :integer
  end
end
