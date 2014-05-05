class PostsController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

# Because we need a way to list all our posts, we'll use a specific route from config/routes.rb:
# posts GET    /posts(.:format)          posts#index
# and an action for that route inside the PostsController:
  def index
    @posts = Post.all.order(created_at: :desc).limit(10)
  end
# And then finally a view for this action, located at app/views/posts/index.html.erb



####################################
############### SHOW ###############
####################################
# In the output of rake routes, the route for show action is as follows:
# post GET    /posts/:id(.:format)      posts#show
# The special syntax :id tells rails that this route expects an :id parameter, which in our case will be the id of the post.
# As we did before, we need to add the show action in app/controllers/posts_controller.rb and its respective view:
  def show
    @post = Post.find(params[:id])
  end
# We use Post.find to find the post we're interested in.
# We also use an instance variable (prefixed by @) to hold a reference to the post object.
# We do this because Rails will pass all instance variables to the view.



####################################
############### EDIT ###############
####################################
  def edit
    @post = Post.find(params[:id])
  end



######################################
############### UPDATE ###############
######################################
# The update method is used when you want to update a record that already exists, and it accepts a hash
# containing the attributes that you want to update.
  def update
    @post = Post.find(params[:id])

    if @post.update(params[:post].permit(:title, :text))
    # if @post.update(post_params)
      redirect_to @post
      # redirect_to action: :show, id: @post.id
    else
      render 'edit'       # As before, if there was an error updating the post we want to show the form back to the user.
    end
  end



###################################
############### NEW ###############
###################################
# The reason why we added @post = Post.new here [in posts_controller] is that otherwise @post would be nil in our view, and calling @post.errors.any? [in app/views/posts/new.html.erb] would throw an error.
  def new
    @post = Post.new
  end



######################################
############### CREATE ###############
######################################
  def create
# Here's what's going on: every Rails model can be initialized with its respective attributes, which are automatically
# mapped to the respective database columns.
# In the first line we do just that (remember that params[:post] contains the attributes we're interested in).
    # @post = Post.new(params[:post].permit(:title, :text))
    @post = Post.new(post_params)

    if @post.save           # @post.save is responsible for saving the model in the database.
      redirect_to @post     # redirect the user to the show action [@post.save will return a boolean indicating whether the model was saved or not.]
      # redirect_to action: :show, id: @post.id
      # redirect_to posts_path
    else
      render 'new'          # The render method is used so that the @post object is passed back to the new template when it is rendered.
                            # This rendering is done within the same request as the form submission, whereas the redirect_to will tell the browser to issue another request.
    end
  end
# When a form is submitted, the fields of the form are sent to Rails as PARAMETERS.
# These parameters can then be referenced inside the controller actions, typically to perform a particular task.

  # def create
  #   render text: params[:post].inspect
  # end
# The render method here is taking a very simple hash with a key of
# TEXT [ = text: ] and
# value of PARAMS[:POST].INSPeCT [ = params[:post].inspect ].
# The params method is the object which represents the parameters (or fields) coming in from the form.
# The params method returns an ActiveSupport::HashWithIndifferentAccess object, which allows you to access
# the keys of the hash using either strings or symbols.
# In this situation, the only parameters that matter are the ones from the form.
# OUTPUT: {"title"=>"First post!", "text"=>"This is my first post."}
# This action is now displaying the parameters for the post that are coming in from the form, but this isn't really helpful.




#######################################
############### DESTROY ###############
#######################################
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  # redirect_to action: :index
  end
# You can call destroy on Active Record objects when you want to delete them from the database.
# Note that we don't need to add a view for this action since we're redirecting to the index action.



private # Note that def post_params is private. This new approach prevents an attacker from setting the model's attributes by manipulating the hash passed to the model.

    def post_params
      params.require(:post).permit(:title, :text) # "permit" allows us to accept both title and text in this action.
    end
  end










