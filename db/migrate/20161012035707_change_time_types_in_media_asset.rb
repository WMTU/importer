class ChangeTimeTypesInMediaAsset < ActiveRecord::Migration
  def change
    change_column :media_assets, :cue, :string, limit: 12, default: "00:00:00.000"
    change_column :media_assets, :intro, :string, limit: 12, default: "00:00:00.000"
    change_column :media_assets, :eom, :string, limit: 12
  end
end
