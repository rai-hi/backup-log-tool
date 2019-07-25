# frozen_string_literal: true

require 'parsed_deletion_event'

describe ParsedDeletionEvent do
  describe '.successful?' do
    context 'successful' do
      subject do
        described_class.new(
          backup_id: 'a810',
          backup_created_at: DateTime.now,
          status_code: 'Removed 200'
        )
      end

      it 'returns true if status code is a 200' do
        expect(subject.successful?).to eq(true)
      end
    end

    context 'unsuccessful' do
      subject do
        described_class.new(
          backup_id: 'a810',
          backup_created_at: DateTime.now,
          status_code: 'Error 404',
          error_description: "{'test': 'not_found'}"
        )
      end

      it 'returns false if status code is not' do
        expect(subject.successful?).to eq(false)
      end
    end
  end

  describe '#==' do
    it 'returns true if both objects have the same id & created at' do
      created_at = DateTime.now
      first = described_class.new(
        backup_id: 'a810',
        backup_created_at: created_at,
        status_code: 'Error 404',
        error_description: "{'test': 'not_found'}"
      )
      second = described_class.new(
        backup_id: 'a810',
        backup_created_at: created_at,
        status_code: 'NOT THE SAME',
        error_description: '{NOT THE SAME}'
      )
      expect(first).to eq(second)
    end

    it 'returns false if both objects have different ids' do
      created_at = DateTime.now
      first = described_class.new(
        backup_id: 'a811',
        backup_created_at: created_at,
        status_code: 'Error 404',
        error_description: "{'test': 'not_found'}"
      )
      second = described_class.new(
        backup_id: 'a810',
        backup_created_at: created_at,
        status_code: 'NOT THE SAME',
        error_description: '{NOT THE SAME}'
      )
      expect(first).to_not eq(second)
    end

    it 'returns false if both objects have different created_at' do
      created_at = DateTime.now
      first = described_class.new(
        backup_id: 'a810',
        backup_created_at: created_at,
        status_code: 'Error 404',
        error_description: "{'test': 'not_found'}"
      )
      second = described_class.new(
        backup_id: 'a810',
        backup_created_at: created_at + 1,
        status_code: 'NOT THE SAME',
        error_description: '{NOT THE SAME}'
      )
      expect(first).to_not eq(second)
    end
  end
end
