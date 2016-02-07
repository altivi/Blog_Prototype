class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text 
      t.references :post
      t.references :user
      t.timestamps null: false
    end
  end
end
