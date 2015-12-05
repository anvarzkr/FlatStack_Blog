class RemoveNicknameFromComments < ActiveRecord::Migration
  def change
    remove_column :comments, :nickname, :string
  end
end
