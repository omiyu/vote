class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:show]
  require 'csv'

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @sex = User.devide_sex(@user.sex)

    @graphs = []
    current_user_make_id = Make.where(user_id: @current_user.id)
    make_summaries = MakeSummary.where(make_id: current_user_make_id).order(id: "DESC")

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


  def new
    @user = User.new
    @profession = Constants::PROFFESSION
    @prefectur = Constants::PREFECTUR
    @annual_income = Constants::ANNUALINCOME
  end

  # GET /users/1/edit
  def edit
  end


  def create
    @user = User.new(
      name: params[:user][:name],
      email: params[:user][:email],
      account_name: params[:user][:account_name],
      age: params[:user][:age],
      sex: params[:user][:sex],
      profession: params[:user][:profession],
      address_pref: params[:user][:address_pref],
      annual_income: params[:user][:annual_income],
      password: params[:user][:password])

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      @profession = Constants::PROFFESSION
      @prefectur = Constants::PREFECTUR
      @annual_income = Constants::ANNUALINCOME
      render("/users/new")
    end

  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy

    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      redirect_to("/makes?sort=new")
    end
  end



  def login_form

  end

  def login
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to("/users/#{@user.id}")
    else
      @user_email = params[:session][:email]
      @user_password = params[:session][:password]
      render("login_form")
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to("/login")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
