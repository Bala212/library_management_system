class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.integer :isbn
      t.string :genre
      t.references :library, foreign_key: true
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
