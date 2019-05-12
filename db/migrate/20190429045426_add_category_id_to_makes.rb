class AddCategoryIdToMakes < ActiveRecord::Migration[5.1]
  def change
    add_column :makes, :category_id, :integer
  end
end
