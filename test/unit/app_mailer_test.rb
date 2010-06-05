require 'test_helper'

class AppMailerTest < ActionMailer::TestCase
  def test_attendee_enrolled_admin
    workshop = Factory(:workshop, :title => 'Workshop Title')
    attendee = Factory(:attendee, :name => 'a_name', :phone => '111111111', :email => 'a_email@email.com', :comment => 'wadus comment', :workshop => workshop)
    
    @expected.subject = "[Talleres en la Casa] Alumno se preinscrito al Taller '#{attendee.workshop.title}'"
    @expected.body    = read_fixture('attendee_enrolled_admin')
    @expected.date    = Time.now
    @expected.to      = APP_CONFIG[:admin_emails]
    @expected.from    = APP_CONFIG[:email_from]

    email = AppMailer.create_attendee_enrolled_admin(attendee, @expected.date)
    # File.open( "#{RAILS_ROOT}/test/fixtures/app_mailer/attendee_enrolled_admin", 'w' ) { |f| f.write email.body }
    assert_equal @expected.encoded, email.encoded
  end
  
  def test_attendee_enrolled_attendee
    workshop = Factory(:workshop, :title => 'Workshop Title')
    attendee = Factory(:attendee, :name => 'a_name', :phone => '111111111', :email => 'a_email@email.com', :comment => 'wadus comment', :workshop => workshop)
    
    @expected.subject = "[Talleres en la Casa] Te has preinscrito al Taller '#{attendee.workshop.title}'"
    @expected.body    = read_fixture('attendee_enrolled_attendee')
    @expected.date    = Time.now
    @expected.to      = attendee.email
    @expected.from    = APP_CONFIG[:email_from]

    email = AppMailer.create_attendee_enrolled_attendee(attendee, @expected.date)
    # File.open( "#{RAILS_ROOT}/test/fixtures/app_mailer/attendee_enrolled_attendee", 'w' ) { |f| f.write email.body }
    assert_equal @expected.encoded, email.encoded
  end

end
