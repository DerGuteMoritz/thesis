class ContributionTitle < ActiveRecord::Migration
  def self.up
    change_table :contributions do |t|
      t.string :title
    end
  end

  def self.down
    remove_column :contributions, :title
  end
end
