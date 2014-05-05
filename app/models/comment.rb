class Comment < ActiveRecord::Base
  belongs_to :post
end
# This is very similar to the post.rb model.
# The difference is the line belongs_to :post, which sets up an Active Record association.
