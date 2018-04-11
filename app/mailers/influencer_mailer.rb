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

  # class TestMailer < ActionMailer::Base
  # def message
  #   mail(
  #     :subject => 'Hello from Postmark',
  #     :to  => 'contact@crad.io',
  #     :from => 'info@crad.io',
  #     :html_body => '<strong>Hello</strong> dear Postmark user.',
  #     :track_opens => 'true')
  # end
end
# end
