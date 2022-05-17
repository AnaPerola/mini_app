class RemoveDateTimeFromComment < ActiveRecord::Migration[6.0]
  def change

    remove_column :comments, :date_time, :time
  end
end
