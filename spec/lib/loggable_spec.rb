# frozen_string_literal: true

require 'loggable'

describe Loggable do
  subject { MockLoggable.new }

  describe '#to_log_string' do
    it 'throws a NotImplementedError' do
      expect do
        subject.to_log_string(file_format: {})
      end.to raise_error(NotImplementedError)
    end
  end
end

class MockLoggable
  include Loggable
end
