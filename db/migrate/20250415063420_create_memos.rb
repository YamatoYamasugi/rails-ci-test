class CreateMemos < ActiveRecord::Migration[8.0]
  def change
    create_table :memos do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
