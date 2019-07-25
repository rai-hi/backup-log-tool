# frozen_string_literal: true

require 'log_file_object_parser'
require 'backup_log_file'
require 'backup_log_format'

class BackupLogFileParser < LogFileObjectParser
  private

  def default_format
    BackupLogFormat.create
  end

  def collection_from_objects(objects)
    BackupLogFile.new objects
  end

  def object_from_attributes(attributes)
    Backup.new(attributes)
  end

  def attribute_from_string_value(attribute_name, value)
    case attribute_name
    when :created_at
      DateTime.parse value
    else
      value
    end
  end

  def log_file_heading_remappings
    {
      'Created at' => :created_at,
      'Database' => :database_name,
      'ID' => :id,
      'Size' => :filesize,
      'Status' => :status
    }
  end
end
