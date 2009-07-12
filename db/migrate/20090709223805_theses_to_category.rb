class ThesesToCategory < ActiveRecord::Migration
  def self.up
    change_table :theses do |t|
      t.references :category
    end
  end

  def self.down
    remove_column :theses, :category
  end
end
