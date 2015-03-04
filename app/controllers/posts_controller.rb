class PostsController < ApplicationController
  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post
    else
      render json: @post.errors.full_messages, status: 422
    end
  end

  def index
    render json: Post.all
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
