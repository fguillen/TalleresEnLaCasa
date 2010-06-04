ActionController::Routing::Routes.draw do |map|
  map.resources :workshops do |workshops|
    workshops.resources :attendees
  end

  map.resource :sessions
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  
  map.root :controller => "workshops"
end
