# frozen_string_literal: true

require 'backup_log_file'
require 'date'

describe BackupLogFile do
  let(:old_backups) do
    build_list(:backup, 3, created_at: DateTime.now - 35)
  end

  let(:recent_backups) do
    build_list(:backup, 5, created_at: DateTime.now)
  end

  let(:backups) { recent_backups + old_backups }

  subject do
    described_class.new(backups)
  end

  describe '#backups' do
    it 'returns the expected values' do
      expect(subject.backups).to eq(backups)
    end
  end

  describe '#backups_older_than_days' do
    context 'when results match' do
      it 'returns backups older than specified value' do
        expected_backups = old_backups
        expect(subject.backups_older_than_days(30)).to eq(expected_backups)
      end
    end

    context 'when no results match' do
      it 'returns an empty array' do
        expect(subject.backups_older_than_days(99)).to eq([])
      end
    end
  end
end
