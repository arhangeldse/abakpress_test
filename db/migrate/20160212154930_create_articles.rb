class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.integer :level
      t.integer :parent_id
      t.text :slug, limit: 1000
      t.text :slug_full, limit: 1000
      t.text :title
      t.text :text
      t.text :text_html

      t.timestamps null: false
    end
  end
end
