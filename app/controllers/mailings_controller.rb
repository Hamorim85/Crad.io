class MailingsController < ApplicationController
  def index
    # All the former mailings that the brand created
    @mailings = policy_scope(Mailing).order(created_at: :desc)
  end

  def show
    # All the information about this specific mailing
    @mailing = Mailing.find(params[:id])
    authorize @mailing
  end

  def new
    if params[:influencers_ids].present?
      @influencers = policy_scope(Influencer).where(id: params[:influencers_ids].split(","))
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
        temp_mailing = @mailing.dup
        temp_mailing.content.prepend("Dear <InfluencerName>\n\n")
        temp_mailing.content.gsub!(/<InfluencerName>/, influencer.name)
        temp_mailing.content.gsub!(/\n/, '<br />')
        InfluencerMailer.inquiry(influencer, temp_mailing).deliver_now
      end
      redirect_to mailings_path
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
