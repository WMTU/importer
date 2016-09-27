class AddIndexToTokenKey < ActiveRecord::Migration
  def change
    add_index :tokens, :key
  end
end
