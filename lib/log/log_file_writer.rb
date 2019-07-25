# frozen_string_literal: true

require 'pathname'

class LogFileWriter
  APPEND_MODE_FLAG = 'a'

  def initialize(path:, file_format:)
    @path = path
    @file_format = file_format
  end

  def write_line(string)
    file = File.open(@path, APPEND_MODE_FLAG)

    file.puts @file_format.header_line_string if File.empty?(file)
    file.puts string
    file.close
  end

end
