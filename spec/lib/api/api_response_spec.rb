# frozen_string_literal: true

require 'api_response'

describe ApiResponse do
  subject { described_class.new(code: 200, body: 'test') }

  describe '#code' do
    it 'returns the assigned value' do
      expect(subject.code).to eq(200)
    end
  end

  describe '#body' do
    it 'returns the assigned value' do
      expect(subject.body).to eq('test')
    end
  end
end
