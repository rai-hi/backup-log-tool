# frozen_string_literal: true

require 'backup_log_file_parser'
require 'backup_api_client'
require 'backup_api_event'
require 'tempfile'
require 'deletion_log_format'
require 'log_file_writer'
require 'log_file_hash_parser'
require 'backup_deleter'

describe BackupDeleter do
  let(:request_url) { %r{https://example\.com/remove\-backup\?backup_id=.*} }

  let(:test_backup_log_path) { 'spec/support/files/backup_log.txt' }

  let(:backup_deletion_log_file_existing) { 'spec/support/files/deletion_log.txt' }

  let(:backup_deletion_log_file) { Tempfile.new 'deletion_log' }

  let(:expected_output_file_text) do
    <<~FILETEXT
      ID  Created at  Status code  ErrorDescription
      a278  2019-06-08T00:06:19+00:00  Error 404  "{error: 'not found'}"
      a827  2019-06-07T00:08:02+00:00  Error 500  "{error: 'server error'}"
    FILETEXT
  end

  subject do
    described_class.new(
      input_file_path: test_backup_log_path,
      output_file_path: backup_deletion_log_file.path
    )
  end

  describe '#initialize' do
    let(:format) { DeletionLogFormat.create }
    subject do
      described_class.new(
        input_file_path: test_backup_log_path,
        output_file_path: backup_deletion_log_file.path,
        output_file_format: format
      )
    end

    it 'allows the file format to be set' do
      expect(subject.instance_variable_get(:@output_file_format)).to eq(format)
    end
  end

  describe '#delete_and_log_old_backups' do
    it 'parses the backup log, makes API reqs, and logs the deletions' do
      stub_request(:put, request_url)
        .to_return(
          { status: 404, body: "{error: 'not found'}" },
          { status: 500, body: "{error: 'server error'}" },
          { status: 200, body: "{error: 'all good'}" },
          { status: 200, body: '' },
          status: 401, body: "{error: 'something wrong'}"
        )

      subject.delete_and_log_old_backups

      written_deletion_contents = File.read(backup_deletion_log_file.path)
      expect(written_deletion_contents).to eq(expected_output_file_text)
    end
  end
end
