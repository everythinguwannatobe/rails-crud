class PostsController < ApplicationController
    def new
    #사용자가 데이터를 입력할 화면
    #자동으로 액션 이름과 같은 화면을 불러서 사용자에게 보여줘라.
    end
    
    def create
    #입력받은 데이터를 실제 DB에 저장한다.
        @post= Post.new
        @post.title = params[:input_title]
        @post.content = params[:input_content]
        @post.save
        
        redirect_to "/posts/show/#{@post.id}"
    end
    
    def index
        @posts =Post.all
        
    end
    
    def show
        @post = Post.find(params[:post_id])
        @comments = Comment.where(post_id: params[:post_id])
    end
    
    def edit
        #사용자가 데이터를 입력할 화면 
        @post = Post.find(params[:post_id])
    end
    
    def update
        @post = Post.find(params[:post_id])
        @post.title = params[:input_title]
        @post.content = params[:input_content]
        @post.save
        redirect_to "/posts/show/#{@post.id}"
    #입력받은데이터를 실제 db에 저장할 액션
    end
    
    def destroy
        @post =Post.find(params[:post_id])
        @post.destroy
        
        redirect_to '/'
    end
end
