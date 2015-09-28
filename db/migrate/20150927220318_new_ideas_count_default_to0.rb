class NewIdeasCountDefaultTo0 < ActiveRecord::Migration
  def up
    change_column :ideas, :count, :integer, :default => 0
  end

  def down
    change_column :ideas, :count, :integer, :default => nil
  end
end
