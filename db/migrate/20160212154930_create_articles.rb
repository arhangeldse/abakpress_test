class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :slug
      t.string :slug_full
      t.string :title
      t.string :text
      t.string :text_html

      t.timestamps null: false
    end
  end
end
