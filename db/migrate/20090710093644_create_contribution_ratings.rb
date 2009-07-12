class CreateContributionRatings < ActiveRecord::Migration
  def self.up
    create_table :contribution_ratings do |t|
      t.references :user
      t.references :contribution
      t.integer :type
      t.float :value

      t.timestamps
    end
  end

  def self.down
    drop_table :contribution_ratings
  end
end
