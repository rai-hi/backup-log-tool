# frozen_string_literal: true

require 'log_file_format'
require 'backup_log_file_parser'
require 'date'
require 'backup'
require 'backup_api_client'
require 'backup_api_event'
require 'log_file_writer'

class BackupDeleter
  BACKUP_OLDER_THAN_DAYS = 30

  def initialize(input_file_path:, output_file_path:, output_file_format: default_format)
    @input_file_path = input_file_path
    @output_file_path = output_file_path
    @output_file_format = output_file_format
  end

  def delete_and_log_old_backups
    old_backups.map do |backup|
      delete_event = delete_backup(backup)
      log_event(delete_event) if delete_event.failure?
    end
  end

  private

  def default_format
    DeletionLogFormat.create
  end

  def parser
    BackupLogFileParser.new
  end

  def api_client
    BackupApiClient
  end

  def logger
    LogFileWriter.new(file_format: @output_file_format, path: @output_file_path)
  end

  def delete_backup(backup)
    response = api_client.delete_by_id(backup.id)
    BackupApiEvent.new(backup: backup, api_response: response)
  end

  def log_event(delete_event)
    log_string = delete_event.to_log_string(file_format: @output_file_format)
    logger.write_line(log_string)
  end

  def old_backups
    parsed_file.backups_older_than_days(BACKUP_OLDER_THAN_DAYS)
  end

  def parsed_file
    parser.parse_file(@input_file_path)
  end
end
