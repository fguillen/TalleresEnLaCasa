ActionController::Routing::Routes.draw do |map|
  map.resources :workshops do |workshops|
    workshops.resources :attendees
  end

  map.root :controller => "workshops"
end
