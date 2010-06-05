ActionController::Routing::Routes.draw do |map|
  map.resources :workshops do |workshops|
    workshops.resources :attendees, :member => [:confirm_payment]
  end

  map.resource :sessions
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  
  map.connect 'utils/:action', :controller => 'utils'
  
  map.root :controller => "workshops"
end
