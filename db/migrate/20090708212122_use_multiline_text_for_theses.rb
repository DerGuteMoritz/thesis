class UseMultilineTextForTheses < ActiveRecord::Migration
  def self.up
    change_column :theses, :text, :text
  end

  def self.down
    change_column :theses, :text, :string
  end
end
