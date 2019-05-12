class CreateVotings < ActiveRecord::Migration[5.1]
  def change
    create_table :votings do |t|
      t.integer :make_id
      t.integer :user_id
      t.integer :answer_id

      t.timestamps
    end
  end
end
