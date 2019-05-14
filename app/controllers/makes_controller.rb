class MakesController < ApplicationController
  require 'csv'
  PER = 9

  #before_action :set_make, only: [:show, :edit, :update, :destroy]

  #params[:sort]が "ranking"かそれ以外のとき
  def index
    @graphs = []
    #paramsによって表示を変更
    if params[:sort] === "new"
      make_summaries = MakeSummary.all.order(id: "DESC")
      @page_name = "New"
    else
      make_summaries = MakeSummary.all.order(answer_all_ct: "DESC")
      @page_name = "Ranking"
    end
    make_summaries.each_with_index do |make_summary, i|
      data = [
        [make_summary.make.answer_1, make_summary.calculation_rate(make_summary.answer_1_ct,make_summary.answer_all_ct)],
        [make_summary.make.answer_2, make_summary.calculation_rate(make_summary.answer_2_ct,make_summary.answer_all_ct)],
        [make_summary.make.answer_3, make_summary.calculation_rate(make_summary.answer_3_ct,make_summary.answer_all_ct)],
        [make_summary.make.answer_4, make_summary.calculation_rate(make_summary.answer_4_ct,make_summary.answer_all_ct)],
        [make_summary.make.answer_5, make_summary.calculation_rate(make_summary.answer_5_ct,make_summary.answer_all_ct)],
        [make_summary.make.answer_6, make_summary.calculation_rate(make_summary.answer_6_ct,make_summary.answer_all_ct)],
        [make_summary.make.answer_7, make_summary.calculation_rate(make_summary.answer_7_ct,make_summary.answer_all_ct)],
        [make_summary.make.answer_8, make_summary.calculation_rate(make_summary.answer_8_ct,make_summary.answer_all_ct)],
        [make_summary.make.answer_9, make_summary.calculation_rate(make_summary.answer_9_ct,make_summary.answer_all_ct)],
        [make_summary.make.answer_10, make_summary.calculation_rate(make_summary.answer_10_ct,make_summary.answer_all_ct)]
      ]
      graph = LazyHighCharts::HighChart.new("chart#{i}") do |c|
        c.title(text: "Q. " + make_summary.make.question)
        c.series(name: "投票率", data: data, type: 'pie',　colorByPoint: true)
      end
      graph[0][:make_id] = make_summary.make.id
      graph[0][:answer_all_ct] = make_summary.answer_all_ct
      @graphs << graph


    end
  end

  def show
    @make = Make.find_by(id: params[:id])
    @category = Category.find_by(id: @make.category_id)
  end

  # GET /makes/new
  def new
    @make = Make.new
    @category = Category.all
  end

  # GET /makes/1/edit
  def edit
  end

  # POST /makes
  # POST /makes.json
  def create
    make = Make.new(
      question: params[:make][:question],
      category_id: params[:make][:category_id],
      answer_1: params[:make][:answer_1],
      answer_2: params[:make][:answer_2],
      answer_3: params[:make][:answer_3],
      answer_4: params[:make][:answer_4],
      answer_5: params[:make][:answer_5],
      answer_6: params[:make][:answer_6],
      answer_7: params[:make][:answer_7],
      answer_8: params[:make][:answer_8],
      answer_9: params[:make][:answer_9],
      answer_10: params[:make][:answer_10],
      user_id: @current_user.id)

    if make.save
      make_summary = MakeSummary.create(
        make_id: make.id,
        answer_1_ct: 0,
        answer_2_ct: 0,
        answer_3_ct: 0,
        answer_4_ct: 0,
        answer_5_ct: 0,
        answer_6_ct: 0,
        answer_7_ct: 0,
        answer_8_ct: 0,
        answer_9_ct: 0,
        answer_10_ct: 0)
      redirect_to("/makes/#{make.id}")
    else
      @make = Make.new(
        question: params[:make][:question],
        category_id: params[:make][:category_id],
        answer_1: params[:make][:answer_1],
        answer_2: params[:make][:answer_2],
        answer_3: params[:make][:answer_3],
        answer_4: params[:make][:answer_4],
        answer_5: params[:make][:answer_5],
        answer_6: params[:make][:answer_6],
        answer_7: params[:make][:answer_7],
        answer_8: params[:make][:answer_8],
        answer_9: params[:make][:answer_9],
        answer_10: params[:make][:answer_10],
        user_id: @current_user.id)
      @category = Category.all
      render("/makes/new")
    end
  end

  def update
  end

  def destroy
    @make = Make.find_by(id: params[:make_id])
    @make.destroy
    redirect_to(user_path)
  end

  def csv_export # csvダウンロードするチャート
    respond_to do |format|
      format.html
      format.csv do
        create_csv
      end
    end
  end

  private
    def create_csv
      csv_date = CSV.generate do |csv|
        csv_column_names = ["ANSWER","USER_PROFESSION","USER_SEX","USER_AGE","USER_ADDRESS","USER_ANNUAL_INCOME"]
        csv << csv_column_names
        @make = Make.find_by(id: params[:make_id])
        @votings = Voting.where(make_id: @make.id)
        @votings.each do |voting|
          answer = journalize_answer(voting)
          user_profession = voting.user.profession
          user_sex = User.devide_sex(voting.user.sex)
          user_age = voting.user.age
          user_address_pref = voting.user.address_pref
          user_annual_income = voting.user.annual_income
          csv_column_values = [
            answer,
            user_profession,
            user_sex,
            user_age,
            user_address_pref,
            user_annual_income
          ]
          csv << csv_column_values
        end
      end
      send_data(csv_date,filename: "voting.csv")
    end

    def journalize_answer(voting)
      if voting.answer_id === 1 then
        answer = voting.make.answer_1
      elsif voting.answer_id === 2 then
        answer = voting.make.answer_2
      elsif voting.answer_id === 3 then
        answer = voting.make.answer_3
      elsif voting.answer_id === 4 then
        answer = voting.make.answer_4
      elsif voting.answer_id === 5 then
        answer = voting.make.answer_5
      elsif voting.answer_id === 6 then
        answer = voting.make.answer_6
      elsif voting.answer_id === 7 then
        answer = voting.make.answer_7
      elsif voting.answer_id === 8 then
        answer = voting.make.answer_8
      elsif voting.answer_id === 9 then
        answer = voting.make.answer_9
      else
        answer = voting.make.answer_10
      end
      return answer
    end

  #private
    # Use callbacks to share common setup or constraints between actions.
  #  def set_make
  #    @make = Make.find(params[:id])
  #  end

    # Never trust parameters from the scary internet, only allow the white list through.
  #  def make_params
      # params.require(:make).permit(:user_id, :categoe)
  #  end
end
