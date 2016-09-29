class CreateMediaAssets < ActiveRecord::Migration
  def change
    create_table :media_assets do |t|
      t.string :title
      t.string :artist
      t.string :album
      t.string :year
      t.integer :channels
      t.integer :sample_rate
      t.decimal :cue, precision: 16, scale: 3
      t.decimal :intro, precision: 16, scale: 3
      t.decimal :eom, precision: 16, scale: 3
      t.string :audio_file

      t.timestamps null: false
    end
  end
end
