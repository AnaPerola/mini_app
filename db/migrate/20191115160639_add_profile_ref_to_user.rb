class AddProfileRefToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :profile, foreign_key: true
  end
end
