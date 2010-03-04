class Emailer < ActionMailer::Base
  def forgot_password (recipient, pass, sent_at = Time.now)
    subject  "Volunteer Account - Forgotten Password"
    recipients  recipient
    from  "iForgotPass@gmail.com"
    sent_on  sent_at
    body['pass'] = pass
  end
end
