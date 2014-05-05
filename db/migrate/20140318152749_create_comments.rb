class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.references :post, index: true
      # The t.references line sets up a foreign key column for the association between the two models.

      t.timestamps
    end

    add_index :comments, :post_id    # steht so im Tutorial! Aber nicht mehr im fertigen Code auf Github!!!
    # The add_index line sets up an index for this association column.
  end
end


# Active Record associations let you easily declare the relationship between two models.
# In the case of comments and posts, you could write out the relationships this way:
# - Each comment belongs to one post.
# - One post can have many comments.
# In fact, this is very close to the syntax that Rails uses to declare this association.


