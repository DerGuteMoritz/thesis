class ContributionCategory < ActiveRecord::Migration
  def self.up
    change_table :contributions do |t|
      t.references :category
    end
  end

  def self.down
    remove_column :contributions, :category
  end
end
