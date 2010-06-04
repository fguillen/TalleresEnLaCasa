require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    post :create
    assert_redirected_to new_sessions_path
    assert_not_nil( flash[:alert] )
  end
  
  def test_create_valid
    post :create, :password => APP_CONFIG[:password]
    assert_redirected_to workshops_path
    assert_not_nil( flash[:notice] )
    
    assert_equal( true, session[:admin] )
  end
  
  def test_destroy
    session[:admin] = true
    
    post :destroy
    assert_redirected_to workshops_path
    assert_not_nil( flash[:notice] )
    
    assert_nil session[:admin]
  end
end