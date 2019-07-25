# frozen_string_literal: true

require 'log_file_format'

describe LogFileFormat do
  let(:ordered_headings) { %w[id created_at status description] }
  let(:delimeter) { '   ' }

  subject do
    described_class.new(
      ordered_headings: ordered_headings, delimeter: delimeter
    )
  end

  describe '.new' do
    context 'heading attributes' do
      it 'accepts an array of strings' do
        expect do
          described_class.new ordered_headings: ['test']
        end.to_not(raise_error)
      end

      it 'accepts an array of symbols' do
        expect do
          described_class.new ordered_headings: [:test]
        end.to_not(raise_error)
      end

      it 'throws an error if headings is empty' do
        expect { described_class.new ordered_headings: [] }.to(
          raise_error("Ordered headings can't be nil/empty")
        )
      end
    end

    context 'without passing a delimiter' do
      subject { described_class.new(ordered_headings: ordered_headings) }

      it 'returns the expected default delimeter' do
        multiple_consecutive_whitespace = /\s{2,}/
        expect(subject.delimeter).to eq(multiple_consecutive_whitespace)
      end
    end
  end

  describe '#ordered_headings' do
    it 'returns symbols' do
      expect(subject.ordered_headings).to eq(ordered_headings.map(&:to_sym))
    end
  end

  describe '#delimeter' do
    it 'returns the delimeter' do
      expect(subject.delimeter).to eq(delimeter)
    end
  end

  describe '#header_line_string' do
    it 'returns the headings joined by the delimeter' do
      expect(subject.header_line_string).to eq(ordered_headings.join(delimeter))
    end
  end
end
