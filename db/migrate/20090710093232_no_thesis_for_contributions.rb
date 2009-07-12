class NoThesisForContributions < ActiveRecord::Migration
  def self.up
    remove_column :contributions, :thesis_id
  end

  def self.down
    add_column :contributions, :thesis_id, :integer
  end
end
