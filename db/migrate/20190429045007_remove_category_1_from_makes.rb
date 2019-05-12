class RemoveCategory1FromMakes < ActiveRecord::Migration[5.1]
  def change
    remove_column :makes, :category, :string
  end
end
