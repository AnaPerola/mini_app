class AddShareToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :share, :boolean
  end
end
