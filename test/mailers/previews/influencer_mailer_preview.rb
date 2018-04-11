# Preview all emails at http://localhost:3000/rails/mailers/influencer_mailer
class InfluencerMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/influencer_mailer/inquiry
  def inquiry
    InfluencerMailer.inquiry
  end

end
