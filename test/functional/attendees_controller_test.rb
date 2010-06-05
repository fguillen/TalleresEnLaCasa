require 'test_helper'

class AttendeesControllerTest < ActionController::TestCase
  def setup
    AttendeesController.any_instance.stubs(:admin?).returns(true)
    @workshop = Factory(:workshop)
  end
  
  def test_index
    3.times { Factory(:attendee, :workshop => @workshop) }
    get :index, :workshop_id => @workshop.to_param
    assert_template 'index'
    assert_equal( 3, assigns(:attendees).size )
    
    attendee = Attendee.last
    assert_match( attendee.name, @response.body )
  end
  
  def test_show
    attendee = Factory(:attendee, :workshop => @workshop, :comment => 'wadus comment')
    get :show, :workshop_id => @workshop.to_param, :id => attendee.id
    assert_template 'show'
    assert_match( attendee.name, @response.body )
    assert_match( attendee.phone, @response.body )
    assert_match( attendee.email, @response.body )
    assert_match( attendee.comment, @response.body )
  end
  


  
  def test_create_invalid
    Attendee.any_instance.stubs(:valid?).returns(false)
    post :create, :workshop_id => @workshop.to_param
    assert_template 'workshops/show'
    assert_not_nil( flash[:alert] )
  end
  
  def test_create_valid
    attendee_attributes = Factory.attributes_for(:attendee, :comment => 'wadus comment')
    bogus_gateway = ActiveMerchant::Billing::BogusExpressGateway.new
    AttendeesController.any_instance.stubs(:gateway).returns(bogus_gateway)
    
    assert_difference "Attendee.count", 1 do
      post(
        :create,
        :workshop_id => @workshop.to_param,
        :attendee => attendee_attributes
      )      
    end
    
    assert_redirected_to 'http://www.some-express-gateway-url/'
    
    attendee = Attendee.last
    assert_equal( attendee_attributes[:name], attendee.name )
    assert_equal( attendee_attributes[:email], attendee.email )
    assert_equal( attendee_attributes[:phone], attendee.phone )  
    assert_equal( attendee_attributes[:comment], attendee.comment )  
    assert_not_nil( attendee.paypal_token )
  end
  
  def test_confirm_payment
    bogus_gateway = ActiveMerchant::Billing::BogusExpressGateway.new
    AttendeesController.any_instance.stubs(:gateway).returns(bogus_gateway) 
    attendee = Factory(:attendee, :paypal_token => 'wadustoken')
    AppMailer.expects(:deliver_attendee_enrolled_admin).with(attendee)
    AppMailer.expects(:deliver_attendee_enrolled_attendee).with(attendee)
    
    get(
      :confirm_payment,
      :workshop_id => attendee.workshop.to_param,
      :id => attendee.id,
      :token => attendee.paypal_token
    )
    
    assert_redirected_to attendee.workshop
    attendee.reload
    assert_equal( Attendee::STATUS[:paid], attendee.status )
    assert_not_nil( flash[:notice] )
  end

  def test_confirm_payment_error
    bogus_gateway = ActiveMerchant::Billing::BogusExpressGateway.new
    AttendeesController.any_instance.stubs(:gateway).returns(bogus_gateway) 
    bogus_gateway.stubs(:details_for).returns( OpenStruct.new :payer_id => '1', :success? => false )
    attendee = Factory(:attendee, :paypal_token => 'wadustoken')
    AppMailer.expects(:deliver_attendee_enrolled_admin).never
    AppMailer.expects(:deliver_attendee_enrolled_attendee).never
    
    get(
      :confirm_payment,
      :workshop_id => attendee.workshop.to_param,
      :id => attendee.id,
      :token => attendee.paypal_token
    )
    
    assert_redirected_to attendee.workshop
    attendee.reload
    assert_equal( Attendee::STATUS[:error], attendee.status )
    assert_not_nil( flash[:alert] )
  end
  
  def test_edit
    attendee = Factory(:attendee, :workshop => @workshop)
    get :edit, :workshop_id => @workshop.to_param, :id => attendee.id
    assert_template 'edit'
  end
  
  def test_update_invalid
    attendee = Factory(:attendee, :workshop => @workshop)
    Attendee.any_instance.stubs(:valid?).returns(false)
    put(
      :update, 
      :id => attendee.id,
      :workshop_id => @workshop.to_param
    )
    assert_template 'edit'
    assert_not_nil( flash[:alert] )
  end
  
  def test_update_valid
    attendee = Factory(:attendee, :workshop => @workshop)
    attendee_new_attributes = Factory.attributes_for(:attendee, :comment => 'wadus comment')
    
    put :update, :id => attendee.id, :workshop_id => @workshop.to_param, :attendee => attendee_new_attributes
    
    assert_redirected_to [@workshop, attendee]
    
    attendee.reload
    assert_equal( attendee_new_attributes[:name], attendee.name )
    assert_equal( attendee_new_attributes[:email], attendee.email )
    assert_equal( attendee_new_attributes[:phone], attendee.phone )  
    assert_equal( attendee_new_attributes[:comment], attendee.comment )
  end
  
  def test_destroy
    attendee = Factory(:attendee, :workshop => @workshop)
    delete :destroy, :workshop_id => @workshop.to_param, :id => attendee.id
    assert_not_nil( flash[:notice] )
    assert_redirected_to @workshop
    assert !Attendee.exists?(attendee.id)
  end
end
