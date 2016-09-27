module Scot
  class FormatChunk < BinData::Record
    endian  :little

    string  :id,            value: "fmt "
    int32   :chunk_size,    value: 40
    int16   :tag                                                      # 1 = PCM, 80 = MPEG
    int16   :channels                                                 # 1 = mono, 2 = stereo
    int32   :sample_rate                                              # sample rate in Hz
    int32   :transfer_rate                                            # channels * sample_rate * (sample_size / 8)
    int16   :alignment                                                # channels * (sample_size / 8)
    int16   :sample_size,   value: lambda { tag == 1 ? 16 : 0 }    # PCM -> 16, MPEG -> 0
    int16   :extra,         value: lambda { tag == 1 ? 0 : 22 }    # PCM -> 0, MPEG -> 22
    int16   :layer                                                    # MPEG -> 1, 2 or 3
    int32   :bit_rate,      value: lambda { tag == 1 ? 0 : 40000 } # PCM -> 0, MPEG -> 40000
    int16   :mode,          value: 0
    int16   :ext_mode,      value: 0
    int16   :emphasis,      value: 0
    int16   :flags,         value: 0
    int32   :pts_low,       value: 0
    int32   :pts_high,      value: 0
  end
end
