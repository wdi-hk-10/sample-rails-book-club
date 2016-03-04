class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text       :content
      
      t.belongs_to :user, index: true
      t.belongs_to :book, index: true

      t.timestamps null: false
    end
  end
end
