if __FILE__ == $0
  # TODO temporary filenames
  inputfile   = "inputfile.m4a"
  metafile    = inputfile + ".meta"
  outputfile  = inputfile + ".wav"

  # save metadata of inputfile to metafile
  `ffmpeg -y -v error -i #{inputfile} -f ffmetadata #{metafile}`
  `ffprobe -v error -show_entries stream=sample_rate,channels #{inputfile} >> #{metafile}`

  # extract needed metadata values from metafile into new format and scott chunks
  format_chunk      = FormatChunk.new
  format_chunk.tag  = 1
  scott_chunk       = ScottChunk.new
  File.open(metafile, "r") do |f|
    f.each_line do |line|
      key, value = line.chomp.split('=', 2)
      case key.downcase
      when "title"
        scott_chunk.title         = value
      when "artist"
        scott_chunk.artist        = value
      when "album"
        scott_chunk.trivia        = value
      when "date"
        scott_chunk.year          = value[0,4]
      when "channels"
        @channels                 = value.to_i
      when "sample_rate"
        format_chunk.sample_rate  = value.to_i
        scott_chunk.sample_rate   = value.to_i / 100
      end
    end
  end

  # if more than two channels, add flag to downmix to stereo
  if @channels > 2
    @channels_arg         = "-ac 2 "
    format_chunk.channels = 2
  else
    @channels_arg         = ""
    format_chunk.channels = @channels
  end

  # convert inputfile to raw 16-44.1 PCM outputfile and read raw PCM into new data chunk
  `ffmpeg -y -v error -i #{inputfile} -f s16le -acodec pcm_s16le #{@channels_arg}#{outputfile}.pcm`
  data_chunk      = DataChunk.new
  data_chunk.data = File.open("#{outputfile}.pcm", "rb") { |f| f.read }

  # create fact chunk, and populate fields in fact, format and scott chunks
  fact_chunk                  = FactChunk.new
  fact_chunk.num_samples      = data_chunk.data.length / 2
  format_chunk.alignment      = format_chunk.channels * format_chunk.sample_size / 8
  format_chunk.transfer_rate  = format_chunk.alignment * format_chunk.sample_rate
  seconds                     = data_chunk.data.length.fdiv(format_chunk.transfer_rate)
  scott_chunk.end_seconds     = seconds.floor
  scott_chunk.end_hundredths  = (seconds % seconds.floor * 100).round
  scott_chunk.eom_start       = (seconds * 10).round
  minutes                     = (seconds / 60).floor
  seconds                     = seconds % 60
  if minutes > 99 && seconds.round > 59
    hour                      = minutes / 60
    minutes                   = minutes % 60
    scott_chunk.ascii_length  = "%d%02d%02d" % [hours, minutes, seconds.round]
    scott_chunk.attrib_2      = 1
  else
    scott_chunk.ascii_length  = "%d:%02d" % [minutes, seconds.round]
  end
  if format_chunk.channels == 1 then scott_chunk.stereo = "M" end

  # create riff chunk and insert other chunks
  riff_chunk              = RiffChunk.new
  riff_chunk.format_chunk = format_chunk
  riff_chunk.scott_chunk  = scott_chunk
  riff_chunk.fact_chunk   = fact_chunk
  riff_chunk.data_chunk   = data_chunk

  # calculate total file length
  riff_chunk.scott_chunk.file_length = riff_chunk.data_chunk.data.abs_offset + riff_chunk.data_chunk.data.length

  # write scott studios wave file
  File.open("#{outputfile}", "wb") { |f| riff_chunk.write(f) }
end
