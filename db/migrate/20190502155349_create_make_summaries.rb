class CreateMakeSummaries < ActiveRecord::Migration[5.1]
  def change
    create_table :make_summaries do |t|
      t.integer :make_id
      t.integer :answer_1_ct
      t.integer :answer_2_ct
      t.integer :answer_3_ct
      t.integer :answer_4_ct
      t.integer :answer_5_ct
      t.integer :answer_6_ct
      t.integer :answer_7_ct
      t.integer :answer_8_ct
      t.integer :answer_9_ct
      t.integer :answer_10_ct

      t.timestamps
    end
  end
end
