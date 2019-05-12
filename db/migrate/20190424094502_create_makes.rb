class CreateMakes < ActiveRecord::Migration[5.1]
  def change
    create_table :makes do |t|
      t.integer :user_id
      t.string :categoe

      t.timestamps
    end
  end
end
