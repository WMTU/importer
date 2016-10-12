class MediaAsset < ActiveRecord::Base
  after_create :extract_meta
  mount_uploader :audio_file, AudioFileUploader

  DURATION_FORMAT = /(?:|\d{2}:)\d{2}:\d{2}\.\d{3}/
  validates_format_of :cue, with: DURATION_FORMAT
  validates_format_of :intro, with: DURATION_FORMAT
  validates_format_of :eom, with: DURATION_FORMAT, allow_blank: true

  private
    def extract_meta
      file = self.audio_file.current_path
      meta =  `ffmpeg -y -v quiet -i #{file} -f ffmetadata -`
      meta += `ffprobe -v quiet -show_entries stream=sample_rate,channels #{file}`

      meta.each_line do |line|
        key, value = line.chomp.split('=', 2)
        next if value.nil?

        case key.downcase
        when "title"
          update_attribute(:title, value)
        when "artist"
          update_attribute(:artist, value)
        when "album"
          update_attribute(:album, value)
        when "date"
          update_attribute(:year, value[0,4])
        when "channels"
          update_attribute(:channels, value.to_i)
        when "sample_rate"
          update_attribute(:sample_rate, value.to_i)
        end
      end
    end
end
