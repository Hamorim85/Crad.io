class InfluencersController < ApplicationController
  before_action :set_influencer, only: %i[show edit update destroy]
  skip_before_action :authenticate_person!

  def index
    @influencers = policy_scope(Influencer).validated.search(params).page(params[:page])
    @categories = params[:categories].nil? ? [] : params[:categories].split(',')
    authorize @influencers
  end

  def show
    authorize @influencer
  end

  private

  def set_influencer
    @influencer = Influencer.find(params[:id])
  end

  def influencer_params
    params.require(:influencer).permit(:min_f, :max_f)
  end
end
