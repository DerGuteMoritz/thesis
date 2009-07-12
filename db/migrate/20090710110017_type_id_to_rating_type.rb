class TypeIdToRatingType < ActiveRecord::Migration
  def self.up
    rename_column :contributions, :type_id, :rating_type
  end

  def self.down
    rename_column :contributions, :rating_type, :type_id
  end
end
