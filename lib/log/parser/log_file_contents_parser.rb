# frozen_string_literal: true

class LogFileContentsParser
  attr_reader :delimeter

  def initialize(delimeter:)
    @delimeter = delimeter
    @string = ''
  end

  def parse_string(string)
    @string = string
    data_rows.map do |row|
      parse_row_to_hash(row)
    end
  end

  private

  def data_rows
    all_rows[1..-1]
  end

  def parse_row_to_hash(string)
    row_values = split_by_delimeter(string)

    row_values_hash = row_values.map.with_index do |value, index|
      column_heading = headings[index]
      hash_key = column_heading
      [hash_key, value]
    end.to_h

    row_values_hash
  end

  def all_rows
    @string.split("\n")
  end

  def headings
    split_by_delimeter(header_row)
  end

  def split_by_delimeter(string)
    string.strip.split(delimeter)
  end

  def header_row
    all_rows[0]
  end
end
