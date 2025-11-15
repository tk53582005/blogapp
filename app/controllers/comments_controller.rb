class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.save
      redirect_to article_path(@article), notice: 'コメントを追加'
    else
      flash.now[:error] = '更新できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end