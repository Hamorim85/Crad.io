class InfluencerMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.influencer_mailer.inquiry.subject
  #
  def inquiry(influencer)
    @influencer = influencer

    mail(to: @influencer.email, subject: "Influencer Marketing Inquiry")
  end
end
