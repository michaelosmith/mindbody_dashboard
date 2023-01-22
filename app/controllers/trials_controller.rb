class TrialsController < ApplicationController
  before_action :set_trial, only: %i[ show edit update destroy ]
  before_action :set_user

  # GET /trials or /trials.json
  def index
    @trials = @user.trials
  end

  # GET /trials/1 or /trials/1.json
  def show
  end

  # GET /trials/new
  def new
    @trial = @user.trials.new
  end

  # GET /trials/1/edit
  def edit
  end

  # POST /trials or /trials.json
  def create
    @trial = @user.trials.new(trial_params)

    respond_to do |format|
      if @trial.save
        format.html { redirect_to user_trials_path(@user), notice: "Trial was successfully created." }
        format.json { render :show, status: :created, location: @trial }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @trial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trials/1 or /trials/1.json
  def update
    respond_to do |format|
      if @trial.update(trial_params)
        format.html { redirect_to @trial, notice: "Trial was successfully updated." }
        format.json { render :show, status: :ok, location: @trial }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trials/1 or /trials/1.json
  def destroy
    @trial.destroy
    respond_to do |format|
      format.html { redirect_to trials_url, notice: "Trial was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trial
      @trial = @user.trials.find(params[:id])
    end

    def set_user
      @user = User.find_by(slug: params[:user_slug])
    end

    # Only allow a list of trusted parameters through.
    def trial_params
      params.require(:trial).permit(:name, :description, :price, :image)
    end
end
