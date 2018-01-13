class Comment < ActiveRecord::Base
    #post에 속해있다.
    belongs_to :post
end
