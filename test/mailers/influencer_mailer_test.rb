require 'test_helper'

class InfluencerMailerTest < ActionMailer::TestCase
  test "inquiry" do
    mail = InfluencerMailer.inquiry
    assert_equal "Inquiry", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
