require 'test_helper'

class WorkshopsControllerTest < ActionController::TestCase
  def test_index
    3.times { Factory(:workshop) }
    get :index
    assert_template 'index'
    assert_equal( 3, assigns(:workshops).size )
    
    workshop = Workshop.last
    assert_match( workshop.title, @response.body )
    assert_match( workshop.short_description, @response.body )
  end
  
  def test_show
    workshop = Factory(:workshop)
    attendee = Factory(:attendee, :workshop => workshop)
    get :show, :id => workshop.to_param
    assert_template 'show'
    assert_match( workshop.title, @response.body )
    assert_match( workshop.description, @response.body )
    
    assert_match( attendee.name, @response.body )
    
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Workshop.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
    assert_not_nil( flash[:alert] )
  end
  
  def test_create_valid
    workshop_attributes = Factory.attributes_for(:workshop)
    
    assert_difference "Workshop.count", 1 do
      post(
        :create,
        :workshop => workshop_attributes
      )      
    end
    
    assert_redirected_to workshop_url(assigns(:workshop))
    assert_not_nil(flash[:notice])
    
    workshop = Workshop.last
    assert_equal( workshop_attributes[:title], workshop.title )
    assert_equal( workshop_attributes[:description], workshop.description )
    assert_equal( workshop_attributes[:short_description], workshop.short_description )  
  end
  
  def test_edit
    get :edit, :id => Factory(:workshop).to_param
    assert_template 'edit'
  end
  
  def test_update_invalid
    workshop = Factory(:workshop)
    Workshop.any_instance.stubs(:valid?).returns(false)
    put(
      :update, 
      :id => workshop.to_param
    )
    assert_template 'edit'
    assert_not_nil( flash[:alert] )
  end
  
  def test_update_valid
    workshop = Factory(:workshop)
    workshop_new_attributes = Factory.attributes_for(:workshop)
    
    put :update, :id => workshop.to_param, :workshop => workshop_new_attributes
    
    assert_redirected_to workshop_url(assigns(:workshop))
    
    workshop.reload
    assert_equal( workshop_new_attributes[:title], workshop.title )
    assert_equal( workshop_new_attributes[:description], workshop.description )
    assert_equal( workshop_new_attributes[:short_description], workshop.short_description )
  end
  
  def test_destroy
    workshop = Factory(:workshop)
    delete :destroy, :id => workshop.to_param
    assert_not_nil( flash[:notice] )
    assert_redirected_to workshops_url
    assert !Workshop.exists?(workshop.id)
  end
end
