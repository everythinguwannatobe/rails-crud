# RAILS CRUD 학습 (기본 crud기능 및 댓글기능)

## Model
-post모델
-comment 모델(1:n)
## View
```
+ 새로 post 작성 C
+ 전체 post 보기 R
+ 1개 post 보기 R
+ 1개 post 수정 U
```

## Post controller
### -create-
+ post 새로 작성하는 view용 액션
+ 실제로 db에 저장하는 액션

### -read-
+ 전체를 post를 보여주는 view용 액션
+ 특정 post보여주는 view용 액션

### -update-
+ 특정 post를 수정하기 위한 view용 액션
+ 수정된 내용을 실제로 db에 저장하는 액션

### -delete
+ 특정 post를 삭제하는 액션


## DB관련 부분

### table
```
+ 데이터베이스를 직접 조작은 x
+ rails를 통해 조작
+ rails db gem을 설치하면 데이터베이스의 테이블들을 시각적으로 볼수있음. 
+ 주소/rails/db
+ rails 프로그램과 db프로그램이 다르다! 이 둘을 연결해서 조작이 가능하게 하는것이 migration 파일이다.!
+ 쉽게 말하면 요구사항을 migration파일에 작성해 마이그레이션을 해주면 동작함!
```

## 명령어
```
+ rails g model Post
+ rails g model Comment content:string (댓글의 컬럼을 옆과 같이 미리 정할수있음)
+ rails g controller posts-> s붙이는게 네이밍 컨벤션
```

## create 부분
```
+ @post= Post.new
+ @post.title = params[:input_title] or [’input_title’]
+ @post.content = params[:input_content] 
+ @post.save

+ title과 content는 migration파일에서 정해준 이름
```


## read 부분
```
+ 1)index 액션(글 전체)
1.route
root 'posts#index' 맨 처음페이지가 글 전체이므로
2.뷰
<% @posts.each do |post| %>
<h3><a href="/posts/show/<%= post.id%>"><%= post.id %>: <%= post.title %></a></h3>
<% end %>
3.컨트롤러
@posts =Post.all
```

```
+ 2)show액션 (글 하나하나)
1.route
get '/posts/show/:post_id'=> 'posts#show'
2.뷰 부분
<h3><a href="/posts/show/<%= post.id%>"><%= post.id %>: <%= post.title %></a></h3>
3. 컨트롤러부분
@post = Post.find(params[:post_id])
```

+ +추가+ 글작성시 바로 그 글로 가기 위해
redirect_to "/posts/show/#{@post.id}"

## delete 부분
+ 1)destroy 액션
1.컨트롤러
@post =Post.find(params[:post_id])
@post.destroy
redirect_to '/'

## update 부분
1) edit 액션 (수정화면)
1.컨트롤러 
@post = Post.find(params[:post_id])

2) update액션
1.컨트롤러 
@post = Post.find(params[:post_id])
@post.title = params[:input_title]
@post.content = params[:input_content]
@post.save
redirect_to "/posts/show/#{@post.id}"


## GET/POST
### get-> request data,  post-> Submits data 

+ get 방식은 주소 url로 crud가 가능함!보안상 좋지않음
+ form에 method="post" 추가 default는 get
+ application.controller에서 (protect_from_forgery with: :exception) 부분을 주석처리하고 post 사용
+ 위 부분이 보안관련 내용인데 일단 주석처리하자!
+ 삭제는 data-method="post" 부분을 a태그에 추가하면 delete 실행됨

##1:N (댓글)
+ 댓글을 배열로 저장? no!!! 컬럼에 배열은 들어갈수 없음.
+ 새로운 table 필요!

### 1.모델에 관계표시

+ COMMENT모델
+ ->belongs_to :post
+ POST모델
+ ->has_many :comments

### 2.comment 마이그레이션 파일
+ t.integer :post_id or t.belongs_to :post 둘다 가능 하지만 왼쪽이 더 명시적!


### 3.comments 컨트롤러 만들기
+ rails g controller comments
+ 1.create 액션

뷰 부분 
<form action="/posts/show/<%= @post.id %>/comments/create" method="post">


comment의 컨트롤러 부분 
@comment = Comment.new
@comment.content = params[:input_comment]
@comment.post_id = params[:post_id]
redirect_to "/posts/show/#{params[:post_id]}" 
post의 컨트롤러 부분
@comments = Comment.where(post_id: params[:post_id])

+ 2.destroy 액션
+ @comment =Comment.find(params[:comment_id])
  @comment.destroy
  redirect_to "/posts/show/#{params[:post_id]}"

### post와 연관된 댓글 모두 삭제
+ post.rb 에서 has_many :comments, **dependent: :destroy** 로 변경