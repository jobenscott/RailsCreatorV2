Rails.application.routes.draw do
	# creation center routes
  	root 'creation_center#home'
  	post 'creation_center/new_app' => 'creation_center#new_app'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
