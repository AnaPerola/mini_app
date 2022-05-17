class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.time :date_time
      t.text :body
      t.integer :like_status, default: 0

      t.timestamps
    end
  end
end
