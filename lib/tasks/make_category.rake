namespace :make_category do
  desc "カテゴリのマスターデータを作るバッチ処理"
  task :make => :environment do
    CATEGORY  = ["食べ物・飲み物", "恋愛・結婚", "動物・ペット", "ファッション", "本・雑誌", "アニメ・漫画" "ゲーム", "スポーツ・健康", "エンターテイメント", "音楽","趣味・嗜好","生活","仕事","社会","テクノロジー","サービス","海外","その他",]

    CATEGORY.each do |c|
      category = Category.new
      category.category_name = c
      category.save!
    end
  end
end
