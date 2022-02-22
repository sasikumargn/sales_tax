Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :carts, except: [:index, :destroy] do
    collection do
      get :print_receipt
    end
  end

  root :to => "carts#new"
  match '*path' => redirect('/'), via: :get
end
