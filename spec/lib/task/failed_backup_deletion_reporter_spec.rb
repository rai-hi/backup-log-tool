# frozen_string_literal: true

require 'tempfile'
require 'failed_backup_deletion_reporter'

describe FailedBackupDeletionReporter do
  let(:log_file) { Tempfile.new 'deletion_log' }
  let(:deletion_log_file_path) { 'spec/support/files/deletion_log.txt' }

  subject do
    start_date = DateTime.parse('2019-07-30')
    end_date = DateTime.parse('2019-07-10')

    described_class.new(
      start_date: start_date,
      end_date: end_date,
      log_file_path: deletion_log_file_path
    )
  end

  describe '#success_count' do
    it 'returns the correct count' do
      expect(subject.success_count).to eq(2)
    end
  end

  describe '#failure_count' do
    it 'returns the correct count' do
      expect(subject.failure_count).to eq(2)
    end
  end

  describe '#report' do
    it 'implements a method which reports the results' do
      expect{
        subject.report
      }.to_not raise_error
    end
  end
end
