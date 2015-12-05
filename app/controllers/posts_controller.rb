class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /posts
  # GET /posts.json
  def index
    # @posts = Post.order(created_at: :asc)
    @posts = current_user.posts.order(created_at: :desc)
  end

  def feed
    @posts = Post.all.order(created_at: :desc)
  end

  def user_feed
    @posts = Post.where(user_id: params[:user_id]).order(created_at: :desc)
    render(:feed)
  end

  def user_blog

  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    if @post.views.nil?
      @post.views = 0
    else
      @post.views = @post.views + 1
    end
    @post.save
    @comments = @post.comments.order(created_at: :asc)
  end

  # GET /posts/new
  def new
    # @post = Post.new
    @post = current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    # @post = Post.new(post_params)
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if post_params[:user_id] != current_user.id
      post_params[:user_id] = current_user.id
    end

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy

    if current_user.id != @post.user_id
      return;
    end

    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id, :image)
    end
end
