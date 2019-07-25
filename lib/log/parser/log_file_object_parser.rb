# frozen_string_literal: true

require 'log_file_contents_parser'
require 'log_file_hash_parser'
require 'log_file_contents_parser'

class LogFileObjectParser
  def initialize(file_format: default_format)
    @file_format = file_format
  end

  def parse_file(path)
    attribute_hashes = parser.parse_file(path)
    objects = objects_from_attributes(attribute_hashes)
    collection_from_objects(objects)
  end

  private

  def default_format
    raise NotImplementedError
  end

  def attribute_from_string_value(_attribute_name, _value)
    raise NotImplementedError
  end

  def collection_from_objects(_objects)
    raise NotImplementedError
  end

  def object_from_attributes(_attributes)
    raise NotImplementedError
  end

  def parser
    LogFileHashParser.new(
      contents_parser: LogFileContentsParser.new(delimeter: @file_format.delimeter),
      heading_name_remappings: log_file_heading_remappings
    )
  end

  def objects_from_attributes(attribute_hashes)
    attribute_hashes = attribute_hashes.map do |hash|
      hash.map do |key, string_value|
        value = attribute_from_string_value(key, string_value)
        [key, value]
      end.to_h
    end

    attribute_hashes.map do |attributes|
      object_from_attributes(attributes)
    end
  end
end
