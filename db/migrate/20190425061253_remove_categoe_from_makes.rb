class RemoveCategoeFromMakes < ActiveRecord::Migration[5.1]
  def change
    remove_column :makes, :categoe, :string
  end
end
