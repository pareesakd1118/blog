class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end 

  def new 
    @article = Article.new
  end

  def create 
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entry
    end
  end

  private ##this is a private method, meaning it helps things work smoothly behind the scenes rather than hold direct logic for a CRUD method. This is an example of strong parameters and what its saying is in the article param you can only submit values for title and body attributes, anything else during form submission will be filtered out essentially. 
    def article_params
      params.require(:article).permit(:title, :body)
    end 
end
