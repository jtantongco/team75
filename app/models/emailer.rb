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
    
    link = 'http://localhost:3000/accounts/verify'
    body['short_link'] = link
    body['link'] = link + "?activation_code=#{code}&email=#{recipient}"
  	body['code'] = code
  end

  def volunteer_contract_reminder (recipient, sent_at = Time.now)
  	subject  "Volunteer Account - Volunteer Contract reminder"
    recipients  recipient
    from  "iForgotPass@gmail.com"
    sent_on  sent_at
  end

  def volunteer_deactivation_notification (recipient, sent_at = Time.now)
  	subject  "Volunteer Account - Deactivation notification"
    recipients  recipient
    from  "iForgotPass@gmail.com"
    sent_on  sent_at
  end
  
  def rejection_notification (recipient, dat, pro, sup, hr, td, cm, sent_at = Time.now)
  	subject  "Supervisor Account - Rejection Notification"
    recipients  recipient
    from  "iForgotPass@gmail.com"
    sent_on  sent_at
    body['date'] = dat
  	body['p_id'] = pro
  	body['s_id'] = sup
  	body['hours'] = hr
  	body['task_description'] = td
  	body['comm'] = cm
  end
	
end
