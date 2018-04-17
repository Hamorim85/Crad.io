class InfluencerMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.influencer_mailer.inquiry.subject
  #
  def inquiry(influencer, mailing)
    @influencer = influencer
    @mailing = mailing
    mail(to: @influencer.email, subject: @mailing.subject)
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
