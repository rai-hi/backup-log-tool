# frozen_string_literal: true

require 'log_file_format'
require 'log_file_hash_parser'

describe LogFileHashParser do
  let(:contents_parser) { instance_double('LogFileContentsParser') }
  let(:test_file_path) { 'spec/support/files/backup_log.txt' }
  let(:file_content) { File.read(test_file_path) }

  subject { described_class.new contents_parser: contents_parser }

  describe '.parse_file' do
    it 'returns the result of parsing the string contents of the file' do
      mock_parsed_file = [{ 'test': 'success' }]

      allow(contents_parser).to(
        receive(:parse_string)
          .with(file_content)
          .and_return(mock_parsed_file)
      )

      expect(subject.parse_file(test_file_path)).to eq(mock_parsed_file)
    end

    it 'alters the keys of the returned hash based on the heading_name_remappings' do
      mock_parsed_file = [{ 'test' => 'success' }, { 'test' => 'two' }]
      mappings = { 'test' => :test }
      with_mapped_keys = [{ test: 'success' }, { test: 'two' }]

      parser = described_class.new(
        contents_parser: contents_parser,
        heading_name_remappings: mappings
      )

      allow(contents_parser).to(
        receive(:parse_string)
          .with(file_content)
          .and_return(mock_parsed_file)
      )

      expect(parser.parse_file(test_file_path)).to eq(with_mapped_keys)
    end
  end
end
