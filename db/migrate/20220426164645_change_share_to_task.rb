class ChangeShareToTask < ActiveRecord::Migration[6.0]
  def change
    change_column :tasks, :share, :boolean, :default => true
  end
end
