class AddDetailToMakes < ActiveRecord::Migration[5.1]
  def change
    add_column :makes, :category, :string
    add_column :makes, :answer_1, :string
    add_column :makes, :answer_2, :string
    add_column :makes, :answer_3, :string
    add_column :makes, :answer_4, :string
    add_column :makes, :answer_5, :string
    add_column :makes, :answer_6, :string
    add_column :makes, :answer_7, :string
    add_column :makes, :answer_8, :string
    add_column :makes, :answer_9, :string
    add_column :makes, :answer_10, :string
  end
end
