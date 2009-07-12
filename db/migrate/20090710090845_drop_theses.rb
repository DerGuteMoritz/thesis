class DropTheses < ActiveRecord::Migration
  def self.up
    drop_table :theses
  end

  def self.down
    CreateTheses.up
  end
end
