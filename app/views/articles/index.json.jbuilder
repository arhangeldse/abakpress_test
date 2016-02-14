json.array!(@articles) do |article|
  json.extract! article, :id, :id, :slug, :slug_full, :title, :text, :text_html
  json.url article_url(article, format: :json)
end
