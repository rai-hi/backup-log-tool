# frozen_string_literal: true

require 'deletion_log_file_parser'

class FailedBackupDeletionReporter
  def initialize(start_date:, end_date:, log_file_path:)
    @start_date = start_date.to_date
    @end_date = end_date
    @log_file_path = log_file_path

    @successful_delete_count, @failed_delete_count = query_log_file
  end

  def success_count
    @successful_delete_count
  end

  def failure_count
    @failed_delete_count
  end

  def report
    puts "Successful: #{success_count}"
    puts "Unsuccessful: #{failure_count}"
  end

  private

  def file_parser
    DeletionLogFileParser.new
  end

  def query_log_file
    parsed_log = file_parser.parse_file(@log_file_path)

    success_count = parsed_log.success_count(@start_date, @end_date)
    failure_count = parsed_log.failure_count(@start_date, @end_date)

    [success_count, failure_count]
  end
end
