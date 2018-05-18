ApiTestMongodb::Application.routes.draw do

  resources :shops, only: [:index]
  resources :purchases, only: [:create]
  
end
