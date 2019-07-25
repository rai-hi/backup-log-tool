# frozen_string_literal: true

require 'deletion_log_file'
require 'date'

describe DeletionLogFile do
  recent_date = DateTime.now
  old_date = DateTime.now - 35

  success_status = 'Removed 200'
  failure_status = 'Error 500'

  let(:old_failures) do
    build_list(
      :parsed_deletion_event, 3,
      backup_created_at: old_date, status_code: failure_status
    )
  end

  let(:old_successes) do
    build_list(
      :parsed_deletion_event, 3,
      backup_created_at: old_date, status_code: success_status
    )
  end

  let(:recent_successes) do
    build_list(
      :parsed_deletion_event, 3,
      backup_created_at: recent_date, status_code: success_status
    )
  end

  let(:recent_failures) do
    build_list(
      :parsed_deletion_event, 5,
      backup_created_at: recent_date, status_code: failure_status
    )
  end

  let(:successes) { old_successes + recent_successes }
  let(:failures) { old_failures + recent_failures }

  let(:events) { successes + failures }

  subject do
    described_class.new(events)
  end

  describe '#events' do
    it 'returns the expected values' do
      expect(subject.events).to eq(events)
    end
  end

  describe '#success_count' do
    it 'returns the correct amount' do
      expect(
        subject.success_count(DateTime.now, DateTime.now - 34)
      ).to eq(3)
    end
  end

  describe '#failure_count' do
    it 'returns the correct amount' do
      expect(
        subject.failure_count(DateTime.now, DateTime.now - 34)
      ).to eq(5)
    end
  end
end
