# frozen_string_literal: true

require 'log_file_writer'
require 'tempfile'

describe LogFileWriter do
  let(:written_text) { 'TEST' }

  let(:original_lines) do
    %w[blablabla woowoowoo]
  end

  let(:file) { tempfile }
  let(:file_format) { 
    double = instance_double("LogFileFormat")
    allow(double).to receive(:header_line_string).and_return('heading_line')
    double
  }

  subject { described_class.new path: file.path, file_format: file_format }

  describe '#write_line' do
    it 'appends to the file' do
      subject.write_line(written_text)
      last_line = file_lines.last
      expect(last_line).to eq(written_text)
    end

    it 'leaves the rest of the file unmodified' do
      subject.write_line(written_text)
      should_be_unmodified_lines = file_lines[0..-2]
      expect(should_be_unmodified_lines).to eq(original_lines)
    end
  end

  private

  def file_lines
    file.open
    file_lines = file.read.split("\n")
    file.close
    file_lines
  end

  def tempfile
    file = Tempfile.new 'out'

    original_lines.each do |line|
      file.puts line
    end

    file.close
    file
  end
end
