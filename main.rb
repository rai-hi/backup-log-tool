# frozen_string_literal: true

$LOAD_PATH << './lib'
Dir['./lib/**/*'].sort.each { |f| $LOAD_PATH << f }

require 'backup_deleter'
require 'failed_backup_deletion_reporter'

delete_log_path = './output.txt'
start_date = DateTime.parse('2019-06-01')
end_date = start_date + 30

BackupDeleter.new(
  input_file_path: './spec/support/files/backup_log.txt',
  output_file_path: delete_log_path
).delete_and_log_old_backups

FailedBackupDeletionReporter.new(
  start_date: start_date,
  end_date: end_date,
  log_file_path: delete_log_path
).report
