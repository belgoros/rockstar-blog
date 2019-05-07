class PostsController < ApplicationController
  before_action :set_post, only: [:show, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all
    json_response @posts
  end

  # GET /posts/1
  def show
    json_response @post
  end

  # POST /posts
  def create
    @post = Post.create!(post_params)
    json_response @post, :created
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      head :no_content
    else
      json_response @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    head :no_content
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.permit(:title, :body)
    end
end
