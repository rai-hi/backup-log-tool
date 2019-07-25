# frozen_string_literal: true

require 'log_file_contents_parser'

describe LogFileContentsParser do
  let(:string) do
    <<-FILE_TEXT
      ID  Created at  Status  Size  Database
      a810  2019-07-10 00:08:02 +0000  Completed 2019-07-10 00:18:53 +0000  482.43MB  DATABASE
      a179  2019-07-09 00:06:19 +0000  Completed 2019-07-09 00:23:42 +0000  480.99MB  DATABASE
      a278  2019-07-08 00:06:19 +0000  Completed 2019-07-08 00:16:04 +0000  479.59MB  DATABASE
      a827  2019-07-07 00:08:02 +0000  Completed 2019-07-07 00:18:43 +0000  481.75MB  DATABASE
    FILE_TEXT
  end

  let(:expected_result_attrs) do
    [
      expected_result('a810', '2019-07-10 00:08:02 +0000', 'Completed 2019-07-10 00:18:53 +0000', '482.43MB', 'DATABASE'),
      expected_result('a179', '2019-07-09 00:06:19 +0000', 'Completed 2019-07-09 00:23:42 +0000', '480.99MB', 'DATABASE'),
      expected_result('a278', '2019-07-08 00:06:19 +0000', 'Completed 2019-07-08 00:16:04 +0000', '479.59MB', 'DATABASE'),
      expected_result('a827', '2019-07-07 00:08:02 +0000', 'Completed 2019-07-07 00:18:43 +0000', '481.75MB', 'DATABASE')
    ]
  end

  def expected_result(id, created_at, status, size, database)
    {
      'ID' => id,
      'Created at' => created_at,
      'Status' => status,
      'Size' => size,
      'Database' => database
    }
  end

  subject do
    described_class.new delimeter: '  '
  end

  describe '.parse_string' do
    it 'returns parsed results as a hash' do
      expect(subject.parse_string(string)).to all(be_a(Hash))
    end

    it 'parses the backup log as expected' do
      parsed = subject.parse_string(string)
      expected_results = expected_result_attrs
      expect(parsed).to eq(expected_results)
    end
  end
end
