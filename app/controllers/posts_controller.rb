class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :dislike]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show
    if user_signed_in?
      if @post.post_users.find_by(user_id: current_user.id)
        @can_like_or_dislike = false
      else
        @can_like_or_dislike = true
      end
    end
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  def like
    @post.post_users.create(post_id: @post.id, user_id: current_user.id, already_like_or_dislike: true)
    current_post_like = @post.like
    new_post_like = current_post_like + 1
    @post.update_attributes(like: new_post_like)
    redirect_to @post
  end

  def dislike
    @post.post_users.create(post_id: @post.id, user_id: current_user.id, already_like_or_dislike: true)
    current_post_dislike = @post.dislike
    new_post_dislike = current_post_dislike + 1
    @post.update_attributes(dislike: new_post_dislike)
    redirect_to @post
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:text, :user_id, :like, :dislike)
    end
end
