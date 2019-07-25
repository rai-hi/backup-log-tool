# frozen_string_literal: true

require 'parsed_deletion_event'
require 'deletion_log_file'
require 'deletion_log_format'
require 'log_file_object_parser'

class DeletionLogFileParser < LogFileObjectParser
  private

  def default_format
    DeletionLogFormat.create
  end

  def collection_from_objects(objects)
    DeletionLogFile.new objects
  end

  def object_from_attributes(attributes)
    ParsedDeletionEvent.new(
      backup_created_at: attributes[:backup_created_at],
      backup_id: attributes[:backup_id],
      status_code: attributes[:status_code],
      error_description: attributes[:error_description]
    )
  end

  def attribute_from_string_value(attribute_name, value)
    case attribute_name
    when :backup_created_at
      DateTime.parse value
    else
      value
    end
  end

  def log_file_heading_remappings
    {
      'ID' => :backup_id,
      'Created at' => :backup_created_at,
      'Status Code' => :status_code,
      'ErrorDescription' => :error_description
    }
  end
end
