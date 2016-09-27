class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.text :key
      t.references :user, index: true, foreign_key: true
      t.datetime :expires_at

      t.timestamps null: false
    end
  end
end
