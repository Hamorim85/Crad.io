class MailingsController < ApplicationController
  def index
    # All the former mailings that the brand created
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
    @influencers = Influencer.all.limit(3)
    @mailing = Mailing.new
  end

  def create
    @mailing = Mailing.new(mailing_params)
    @mailing.brand = current_brand

    @influencers = Influencer.all.limit(3)

    @influencers.each do |influencer|
    InfluencerMailer.inquiry(influencer).deliver_now
    end

    # @mailing.influencers << @influencers



    if @mailing.save
      redirect_to mailing_path(@mailing)
    else
      puts @mailing.errors.full_messages
      render :new
    end
  end

  private

  def mailing_params
    params.require(:mailing).permit(:content)
  end

end
