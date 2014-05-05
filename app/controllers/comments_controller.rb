class CommentsController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy # authenticated users will be able to delete comments

  def create
    @post = Post.find(params[:post_id])
    # @comment = @post.comments.create(params[:comment].permit(:commenter, :body))
    #@comment = @post.comments.create(params[:comment])
    @comment = @post.comments.create!(params.require(:comment).permit!)
  # @comment = @post.comments.create(comment_params)
    redirect_to post_path(@post)
  end
# There is a bit more complexity here than in the controller for posts.
# That's a side-effect of the nesting that you've set up.
# Each request for a comment has to keep track of the post to which the comment is attached,
# thus the initial call to the find method of the Post model to get the post in question.

# In addition, the code takes advantage of some of the methods available for an association.
# We use the create method on @post.comments to create and save the comment.
# This will automatically link the comment so that it belongs to that particular post.

# Once we have made the new comment, we send the user back to the original post using the post_path(@post) helper.
# As we have already seen, this calls the show action of the PostsController which in turn renders the show.html.erb
# template.


  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end
# The destroy action will find the post we are looking at, locate the comment within the @post.comments collection,
# and then remove it from the database and send us back to the show action for the post.

end



