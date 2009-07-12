class CreateContributions < ActiveRecord::Migration
  def self.up
    create_table :contributions do |t|
      t.string :text
      t.references :thesis
      t.integer :type
      t.references :author

      t.timestamps
    end
  end

  def self.down
    drop_table :contributions
  end
end
