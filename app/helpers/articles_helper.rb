module ArticlesHelper

  def article_url(article)
    '/' + (article ? article.slug_full.to_s : '')
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

  def get_hierarchy_articles
    Rails.cache.fetch('hierarchy_articles', expires_in: 10.second) do
      list = []
      level = 1
      articles = Article.where('level = ?', level).all
      while articles.length > 0
        list[level] = []
        for i in 0..articles.length - 1
          list[level][articles[i].parent_id] = [] if list[level][articles[i].parent_id].nil?
          list[level][articles[i].parent_id].push(articles[i])
        end
        level += 1
        articles = Article.where('level = ?', level).all
      end
      list
    end
  end

  def get_articles_list(article = nil)
    list = get_hierarchy_articles
    if article.nil?
      level = 1
      parent_id = 0
    else
      level = article.level + 1
      parent_id = article.id
    end
    get_articles_list_recursively(list, level, parent_id)
  end

  def get_articles_list_recursively(list, level, parent_id = 0)
    articles = []
    if (!list[level].nil? && !list[level][parent_id].nil?)
      for i in 0..list[level][parent_id].length - 1
        articles.push(list[level][parent_id][i])
        articles += get_articles_list_recursively(list, level+1, list[level][parent_id][i].id)
      end
    end
    articles
  end

end
