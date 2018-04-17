class MailingsController < ApplicationController
  def index
    # All the former mailings that the brand created
    @mailings = current_brand.mailings
  end

  def show
    # All the information about this specific mailing
    @mailing = Mailing.find(params[:id])
    authorize @mailing
  end

  def new
    if params[:influencers_ids].present?
      @influencers = Influencer.where(id: params[:influencers_ids].split(","))
    end

    @mailing = Mailing.new
    authorize @mailing
  end

  def create
    @mailing = Mailing.new(mailing_params)
    @mailing.brand = current_brand

    @influencers = Influencer.where(id: @mailing.influencers_array.split(","))

    @mailing.influencers << @influencers
    authorize @mailing
    if @mailing.save
      @influencers.each do |influencer|
        InfluencerMailer.inquiry(influencer).deliver_now
      end
      redirect_to mailing_path(@mailing)
    else
      puts @mailing.errors.full_messages
      render :new
    end
  end

  private

  def mailing_params
    params.require(:mailing).permit(:content, :influencers_array)
  end

end
