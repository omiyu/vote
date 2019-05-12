namespace :make_summary do
  desc "投票の集計をするバッチ処理"
  task :make_summary => :environment do
#集計の計算
    make_summaries = MakeSummary.all
    make_summaries.each do |make_summary|
      votings = make_summary.make.votings
      make_summary.update(
        answer_1_ct: votings.where(answer_id: 1).count,
        answer_2_ct: votings.where(answer_id: 2).count,
        answer_3_ct: votings.where(answer_id: 3).count,
        answer_4_ct: votings.where(answer_id: 4).count,
        answer_5_ct: votings.where(answer_id: 5).count,
        answer_6_ct: votings.where(answer_id: 6).count,
        answer_7_ct: votings.where(answer_id: 7).count,
        answer_8_ct: votings.where(answer_id: 8).count,
        answer_9_ct: votings.where(answer_id: 9).count,
        answer_10_ct: votings.where(answer_id: 10).count,
        answer_all_ct: votings.count
      )
    end
  end
end
