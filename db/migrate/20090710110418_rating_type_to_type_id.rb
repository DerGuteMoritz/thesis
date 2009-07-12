class RatingTypeToTypeId < ActiveRecord::Migration
  def self.up
    rename_column :contributions, :rating_type, :type_id
    rename_column :contribution_ratings, :type, :type_id
  end

  def self.down
    rename_column :contributions, :type_id, :rating_type
    rename_column :contribution_ratings, :type_id, :type
  end
end
