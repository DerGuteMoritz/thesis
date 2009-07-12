class ContributionsAsNestedSet < ActiveRecord::Migration
  def self.up
    change_table :contributions do |t|
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
    end
  end

  def self.down
    change_table :contributions do |t|
      t.remove_column :parend_id
      t.remove_column :lft
      t.remove_column :rgt
    end
  end
end
