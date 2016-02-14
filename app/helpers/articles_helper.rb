module ArticlesHelper

  def article_url(article)
    '/' + article.slug_full.to_s
  end


  def article_path(article)
    article_url(article)
  end

  def parent_article_path(article)
    '/' + parent_article_slug(article)
  end

  def parent_article_slug(article)
    slugs = article.slug_full.to_s.split('/')
    slugs.pop
    slugs.join('/')
  end

  def edit_article_path(article)
    article_url(article) + '/edit'
  end

  def new_article_path(article)
    article_url(article) + '/add'
  end

end
