# frozen_string_literal: true

require 'backup_log_file_parser'

describe BackupLogFileParser do
  let(:test_file_path) { 'spec/support/files/backup_log.txt' }

  let(:expected_result_attrs) do
    [
      expected_result('a810', '2019-07-10 00:08:02 +0000', 'Completed 2019-07-10 00:18:53 +0000', '482.43MB', 'DATABASE'),
      expected_result('a179', '2019-07-09 00:06:19 +0000', 'Completed 2019-07-09 00:23:42 +0000', '480.99MB', 'DATABASE'),
      expected_result('a278', '2019-07-08 00:06:19 +0000', 'Completed 2019-07-08 00:16:04 +0000', '479.59MB', 'DATABASE'),
      expected_result('a827', '2019-07-07 00:08:02 +0000', 'Completed 2019-07-07 00:18:43 +0000', '481.75MB', 'DATABASE')
    ]
  end

  describe '.parse_file' do
    it 'parses the backup log as expected' do
      parsed_file = subject.parse_file(test_file_path)
      backups = expected_result_attrs.map { |attrs| Backup.new attrs }

      expect(parsed_file.backups).to match_array(backups)
    end
  end

  private

  def expected_result(id, created_at, status, size, database)
    {
      id: id,
      created_at: created_at,
      status: status,
      filesize: size,
      database_name: database
    }
  end
end
