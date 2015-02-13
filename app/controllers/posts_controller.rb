class PostsController < ApplicationController

  before_action :only_author_can_edit, only: [:edit, :update]
  before_filter :must_be_logged_in, except: :show

  def show
    @post = Post.find(params[:id])
    @all_comments = @post.comments_by_parent_id
    render :show
  end

  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to post_url(@post)
    else
      @subs = Sub.all
      render :new
    end
  end

  def edit
    @subs = Sub.all
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  private

    def post_params
      params.require(:post).permit(:title, :url, :content, sub_ids: [])
    end

    def only_author_can_edit
      @post = Post.find(params[:id])
      unless current_user == @post.author
        flash[:notice] = "Only author can edit this post."
        redirect_to post_url(@post)
      end
    end
end
