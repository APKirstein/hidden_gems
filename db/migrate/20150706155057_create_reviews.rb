class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :user, null: false
      t.belongs_to :restaurant, null: false
      t.integer :value, null: false
      t.integer :proximity, null: false
      t.integer :volume, null: false
      t.integer :originality, null: false
      t.string :body

      t.timestamps null: false
    end
  end
end
