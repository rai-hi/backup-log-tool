# frozen_string_literal: true

class LogFileHashParser
  def initialize(contents_parser:, heading_name_remappings: {})
    @contents_parser = contents_parser
    @heading_name_remappings = heading_name_remappings
  end

  def parse_file(path)
    string = load_file_to_string(path)
    parsed_hashes = @contents_parser.parse_string(string)
    remap_hash_keys(parsed_hashes)
  end

  private

  def remap_hash_keys(hashes)
    hashes.map do |hash|
      remap_hash(hash)
    end
  end

  def remap_hash(hash)
    hash.map do |key, value|
      key = @heading_name_remappings[key] || key
      [key, value]
    end.to_h
  end

  def load_file_to_string(path)
    File.read(path)
  end
end
