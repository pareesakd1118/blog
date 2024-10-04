class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end 

  ##populates the form with a new/empty article model
  def new 
    @article = Article.new
  end

  ##actually saves a new article to the database & redirects to show path (assumsing params are good and validations)
  def create 
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entry
    end
  end

  ##gets the specific article to populate the form with 
  def edit 
    @article = Article.find(params[:id])
  end

  #actually updates the specific article that it selected using the find(params[:id]) & redirects to show article page, it also uses the strong params
  def update 
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else 
      render :new, status: :unprocessable_entry
    end 
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end 

  private ##this is a private method, meaning it helps things work smoothly behind the scenes rather than hold direct logic for a CRUD method. This is an example of strong parameters and what its saying is in the article param you can only submit values for title and body attributes, anything else during form submission will be filtered out essentially. Use this when you are creating or updating. 
    def article_params
      params.require(:article).permit(:title, :body)
    end 
end
