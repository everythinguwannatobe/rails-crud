Rails.application.routes.draw do
 get '/posts/new' => 'posts#new'
 get '/posts/create' => 'posts#create'
 
 get '/posts/index' => 'posts#index'
 get '/posts/show/:post_id' => 'posts#show'
 get '/posts/destroy/:post_id' => 'posts#destroy'
 
 get '/posts/edit/:post_id' => 'posts#edit'
 get '/posts/update/:post_id' => 'posts#update'
 root 'posts#index'
end
