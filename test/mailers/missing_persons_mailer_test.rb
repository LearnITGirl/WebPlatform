require 'test_helper'

class MissingPersonsMailerTest < ActionMailer::TestCase
  test "MissingMentor" do
    mail = MissingPersonsMailer.MissingMentor
    assert_equal "Missingmentor", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
