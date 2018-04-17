class Admin::InfluencersController < ApplicationController
  before_action :set_influencer, only: %i[show edit update destroy]

  def index
    @influencers = ParseService.bio_search(params[:search][:bio])
    @influencers = @influencers.where.not(email: '') if params[:search][:email] == 'true'
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @influencer.update(influencer_params)
        format.html { redirect_to @influencer, notice: 'Influencer was successfully updated.' }
        format.json { render :show, status: :ok, location: @influencer }
      else
        format.html { render :edit }
        format.json { render json: @influencer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @influencer.destroy
    respond_to do |format|
      format.html { redirect_to influencers_url, notice: 'Influencer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_influencer
    @influencer = Influencer.find(params[:id])
  end
end
