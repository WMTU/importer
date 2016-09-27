module Scot
  class File
    def initialize(file)
      raise ArgumentError, 'Given file does not exist' unless File.exist? file
      @file = file
    end
  end
end
