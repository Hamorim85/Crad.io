class MailingsController < ApplicationController
  def index
    # All the former mailings that the brand created
    @mailings = current_brand.mailings
  end

  def show
    # All the information about this specific mailing
    @mailing = Mailing.find(params[:id])
  end

  def new
    # Need to create a test scenario
    # , faking a influencer selection
    # For Example:
    # @influencers = Influencer.all.limit(3)
    if params[:influencers_ids].present?
      @influencers = Influencer.where(id: params[:influencers_ids].split(","))
    end

    @mailing = Mailing.new
  end

  def create
    @mailing = Mailing.new(mailing_params)
    @mailing.brand = current_brand

    @influencers = Influencer.where(id: @mailing.influencers_array.split(","))

    @mailing.influencers << @influencers

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
    params.require(:mailing).permit(:content, :influencers_array, :subject)
  end

end
