class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :post, index: true, foreign_key: true
      t.text :text
      t.date :date
      t.string :nickname

      t.timestamps null: false
    end
  end
end
