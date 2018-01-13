Rails.application.routes.draw do
 #post
 get '/posts/new' => 'posts#new'
 post '/posts/create' => 'posts#create'
 
 get '/posts/index' => 'posts#index'
 get '/posts/show/:post_id' => 'posts#show'
 
 post '/posts/destroy/:post_id' => 'posts#destroy'
 
 get '/posts/edit/:post_id' => 'posts#edit'
 post '/posts/update/:post_id' => 'posts#update'
 root 'posts#index'
 
 #comment
 
 post 'posts/show/:post_id/comments/create' => 'comments#create'
 post '' => 'comments#destroy'
end
