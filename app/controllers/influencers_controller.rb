class InfluencersController < ApplicationController
  before_action :set_influencer, only: %i[show edit update destroy]
  skip_before_action :authenticate_person!

  def index
    @influencers = policy_scope(Influencer).validated.has_email.search(params).where('followers_count BETWEEN 1000000 AND 5000000')
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
    params.require(:influencer).permit(:followers_count, :following_count)
  end
end
