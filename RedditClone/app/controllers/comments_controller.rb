class CommentsController < ApplicationController
  before_filter :must_be_logged_in, except: :show

  def show
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @all_comments = @post.comments_by_parent_id
    render :show
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
    render :new
  end

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      flash[:notice] = "Comment Saved"
      redirect_to :back
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    render :edit
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      flash[:notice] = "Comment updated."
      redirect_to comment_url(@comment)
    else
      render :edit
    end
  end

  def delete
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Comment destroyed."
    redirect_to :back
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :post_id, :parent_comment_id)
    end

end
