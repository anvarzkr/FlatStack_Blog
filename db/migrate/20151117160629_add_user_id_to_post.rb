class AddUserIdToPost < ActiveRecord::Migration
  def change
    add_reference :posts, :user, index: true, foreign_key: true
    # add_column :posts, :user_id, :integer
  end
end
