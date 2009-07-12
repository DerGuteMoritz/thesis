class TypeToTypeId < ActiveRecord::Migration
  def self.up
    rename_column :contributions, :type, :type_id
  end

  def self.down
    rename_column :contributions, :type_id, :type
  end
end
