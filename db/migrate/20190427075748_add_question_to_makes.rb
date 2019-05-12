class AddQuestionToMakes < ActiveRecord::Migration[5.1]
  def change
    add_column :makes, :question, :string
  end
end
