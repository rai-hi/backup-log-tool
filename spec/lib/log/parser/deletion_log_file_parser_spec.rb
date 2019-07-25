# frozen_string_literal: true

require 'deletion_log_file_parser'
require 'parsed_deletion_event'

describe DeletionLogFileParser do
  it_behaves_like 'LogFileObjectParser subclass'

  let(:test_file_path) { 'spec/support/files/deletion_log.txt' }

  let(:expected_result_attrs) do
    [
      expected_result('a622',  '2019-07-05 00:08:03 +0000', 'Removed 200', ''),
      expected_result('a623',  '2019-07-10 00:08:04 +0000', 'Removed 200', ''),
      expected_result('a181',  '2019-07-15 00:08:01 +0000', 'Error 500', "{error: 'invalid ID' }"),
      expected_result('a683',  '2019-07-20 00:08:04 +0000', 'Removed 200', ''),
      expected_result('a182',  '2019-07-25 00:08:05 +0000', 'Error 404', "{error: 'not found' }")
    ]
  end

  subject { described_class.new(file_format: build(:log_file_format)) }

  describe '.parse_file' do
    it 'parses the backup log as expected' do
      parsed_file = subject.parse_file(test_file_path)
      events = expected_result_attrs.map do |attrs|
        ParsedDeletionEvent.new attrs
      end

      expect(parsed_file.events).to match_array(events)
    end
  end

  private

  def expected_result(id, created_at, status, error_description)
    {
      backup_id: id,
      backup_created_at: DateTime.parse(created_at),
      status_code: status,
      error_description: error_description
    }
  end
end
