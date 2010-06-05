class AppMailer < ActionMailer::Base
  

  def attendee_enrolled_admin(attendee, sent_at = Time.now)
    subject    "[Talleres en la Casa] Alumno se preinscrito al Taller '#{attendee.workshop.title}'"
    recipients APP_CONFIG[:admin_emails]
    from       APP_CONFIG[:email_from]
    sent_on    sent_at
    
    body        :attendee => attendee
  end
  
  def attendee_enrolled_attendee(attendee, sent_at = Time.now)
    subject    "[Talleres en la Casa] Te has preinscrito al Taller '#{attendee.workshop.title}'"
    recipients attendee.email
    from       APP_CONFIG[:email_from]
    sent_on    sent_at
    
    body        :attendee => attendee
  end

end
