json.extract! media_asset, :id, :title, :artist, :album, :year, :channels, :sample_rate, :cue, :intro, :eom, :audio_file, :created_at, :updated_at
json.url media_asset_url(media_asset, format: :json)