class AddReferenceLinkCommentToMicroposts < ActiveRecord::Migration[8.0]
  def change
    add_column :microposts, :reference_link_comment, :string
  end
end
