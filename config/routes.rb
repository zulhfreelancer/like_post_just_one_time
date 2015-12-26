Rails.application.routes.draw do
  resources :posts do
  	post 'like', on: :member, as: 'like'
  	post 'dislike', on: :member, as: 'dislike'
  end

  devise_for :users
  root "posts#index"
end
