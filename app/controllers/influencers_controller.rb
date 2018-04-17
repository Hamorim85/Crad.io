class InfluencersController < ApplicationController
  before_action :set_influencer, only: %i[show edit update destroy]
  skip_before_action :authenticate_admin!, :authenticate_brand!

  def index
    @influencers = Influencer.search(params).page(params[:page])
  end

  def show; end

  private

  def set_influencer
    @influencer = Influencer.find(params[:id])
  end

  def influencer_params
    params.require(:influencer).permit(:followers_count, :following_count)
  end
end
