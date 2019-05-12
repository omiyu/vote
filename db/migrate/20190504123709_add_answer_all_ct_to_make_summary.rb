class AddAnswerAllCtToMakeSummary < ActiveRecord::Migration[5.1]
  def change
    add_column :make_summaries, :answer_all_ct, :integer
  end
end
