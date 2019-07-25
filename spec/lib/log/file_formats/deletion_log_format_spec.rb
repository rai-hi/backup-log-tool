# frozen_string_literal: true

require 'deletion_log_format'

describe DeletionLogFormat do
  subject { described_class }

  describe '.format' do
    it 'returns a file format' do
      expect(subject.create).to be_a(LogFileFormat)
    end
  end
end
