# frozen_string_literal: true

require 'backup_log_format'

describe BackupLogFormat do
  subject { described_class }

  describe '.format' do
    it 'returns a file format' do
      expect(subject.create).to be_a(LogFileFormat)
    end
  end
end
