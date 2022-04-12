class AddPriorityToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :priority, :integer, default: 0
  end
end
