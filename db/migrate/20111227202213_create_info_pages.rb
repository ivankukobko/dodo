class CreateInfoPages < ActiveRecord::Migration
  def change
    create_table :info_pages do |t|
      t.string     :title
      t.string     :permalink
      t.text       :body
      t.references :parent
      t.boolean    :promote_to_home, :default => false

      t.timestamps
    end
    add_index :info_pages, :parent_id
  end
end
