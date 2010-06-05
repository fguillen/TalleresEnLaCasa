require 'test_helper'

class ExceptionNotificationTest < ActionController::IntegrationTest
  def test_exception_notification
    UtilsController.any_instance.expects(:local_request?).returns(false)
    UtilsController.any_instance.expects(:consider_all_requests_local).returns(false)
    
    ActionMailer::Base.deliveries = []
    
    get url_for( :controller => 'utils', :action => 'raise_exception' )
    
    mail = ActionMailer::Base.deliveries.first
    assert_not_nil( mail )
    assert_match( "[Talleres en la Casa] ERROR: ", mail.subject )
    assert_equal( APP_CONFIG[:admin_emails], mail.to )
  end
end