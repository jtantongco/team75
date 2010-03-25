class Emailer < ActionMailer::Base
  def forgot_password (recipient, pass, sent_at = Time.now)
    subject  "Volunteer Account - Forgotten Password"
    recipients  recipient
    from  "iForgotPass@gmail.com"
    sent_on  sent_at
    body['pass'] = pass
  end
  
  def confirm_email (recipient, code, sent_at = Time.now)
  	subject  "Volunteer Account - Email confirmation"
    recipients  recipient
    from  "iForgotPass@gmail.com"
    sent_on  sent_at
  	body['code'] = code
  end

  def volunteer_contract_reminder (recipient, sent_at = Time.now)
  	subject  "Volunteer Account - Volunteer Contract reminder"
    recipients  recipient
    from  "iForgotPass@gmail.com"
    sent_on  sent_at
  end
	
end
