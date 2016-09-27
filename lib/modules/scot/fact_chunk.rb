module Scot
  class FactChunk < BinData::Record
    endian  :little

    string  :id,          value: 'fact'
    int32   :chunk_size,  value: 4
    int32   :num_samples                    # total number of samples in the file
  end
end
