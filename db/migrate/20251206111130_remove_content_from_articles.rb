class RemoveContentFromArticles < ActiveRecord::Migration[7.2]
  def up
    remove_column :articles, :content, :text
  end

  def down
    add_column :articles, :content, :text
  end
end