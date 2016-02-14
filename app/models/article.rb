class Article < ActiveRecord::Base
  validates :slug, presence: true
  validates :slug, format: { with: /\A[a-zA-Zа-яА-Я0-9_]+\z/, message: 'only allows [a-zA-Zа-яА-Я0-9_]' }
  validates :title, presence: true
  validates :slug_full, uniqueness: { scope: :slug, message: 'Page with this slug already exist' }

  before_save :before_save

  def before_save
    text = self.text
    text = text.gsub(/\*\*(.*?)\*\*/, '<b>\1</b>')
    text = text.gsub(/\\\\(.*?)\\\\/, '<i>\1</i>')
    text = text.gsub(/\(\((\S+) (.*?)\)\)/, '<a href="\1">\2</a>')
    self.text_html = text
  end

  def prepand_to(article)
    self.level = article.level + 1
    self.parent_id = article.id
    self.slug_full = article.slug_full + '/' + self.slug
  end

  def make_root
    self.level = 1
    self.parent_id = 0
    self.slug_full = self.slug
  end

end
