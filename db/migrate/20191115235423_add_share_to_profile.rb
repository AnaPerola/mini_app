class AddShareToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :share, :boolean, :default => false
  end
end
