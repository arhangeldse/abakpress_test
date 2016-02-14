class ArticlesController < ApplicationController
  include ArticlesHelper
  before_action :set_article, only: [:show, :new, :edit, :create, :update]

  # GET /articles
  # GET /articles.json
  def index
    @articles = get_articles_list
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = @parent_article
    if @article.nil?
      raise ActionController::RoutingError.new('Not Found')
    end
    @articles = get_articles_list(@article)
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article = @parent_article
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    if @parent_article
      @article.prepand_to(@parent_article)
    else
      @article.make_root
    end
    respond_to do |format|
      if @article.save
        format.html { redirect_to URI.encode(article_url(@article)), notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    @article = @parent_article
    respond_to do |format|
      params = article_params
      if @article.update(params)
        format.html { redirect_to URI.encode(article_url(@article)), notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @parent_article = Article.find_by(slug_full: params[:slug])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:slug, :title, :text)
  end
end