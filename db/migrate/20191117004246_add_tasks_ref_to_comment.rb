class AddTasksRefToComment < ActiveRecord::Migration[6.0]
  def change
    add_reference :comments, :task, foreign_key: true
  end
end
