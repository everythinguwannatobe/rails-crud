class Post < ActiveRecord::Base
    #여러댓글을 가지고있다.
    has_many :comments
end
