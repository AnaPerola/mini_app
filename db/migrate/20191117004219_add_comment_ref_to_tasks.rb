class AddCommentRefToTasks < ActiveRecord::Migration[6.0]
  def change
    add_reference :tasks, :comment, foreign_key: true
  end
end
