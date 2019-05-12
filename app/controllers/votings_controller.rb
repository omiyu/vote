class VotingsController < ApplicationController
  before_action :set_voting, only: [:show, :edit, :update, :destroy]

  def index
    @votings = Voting.all
  end

  def show
  end

  def new
    @voting = Voting.new
    @make = Make.find_by(id: params[:make_id])
    @category = Category.find_by(id: @make.category_id)
    #@answers_make =
  end

  def edit
  end

  def create
    @voting = Voting.new(
      make_id: params[:voting][:make_id],
      user_id: @current_user.id,
      answer_id: params[:voting][:answer_id])
    if @voting.save
      redirect_to("/makes/#{@voting.make_id}")
    else
      @make = Make.new(
        make_id: params[:make][:id],
        user_id: @current_user.id,
        answer_id: params[:voting][:answer_id])
      render("/voting/new")
    end
  end

  def update
    respond_to do |format|
      if @voting.update(voting_params)
        format.html { redirect_to @voting, notice: 'Voting was successfully updated.' }
        format.json { render :show, status: :ok, location: @voting }
      else
        format.html { render :edit }
        format.json { render json: @voting.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @voting.destroy
    respond_to do |format|
      format.html { redirect_to votings_url, notice: 'Voting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_voting
      @voting = Voting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def voting_params
      params.require(:voting).permit(:make_id, :user_id, :answer_id)
    end
end
