class Admin::ArticlesController < ApplicationController

  before_action :set_active_link,
    only: %w(index new edit)

  skip_before_action :require_admin!
  skip_before_action :require_sysadmin!

  def index
    @articles = Article.all #.includes(:subdomain)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    @article.save
    redirect_to edit_article_url(@article)
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to edit_article_url(@article)
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])

    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    def article_params
      params.require(:article).permit(
      :title, :subtitle, :author, :content, :image, :remove_image, :link_text, :link_url, :archived
      )
    end
end
