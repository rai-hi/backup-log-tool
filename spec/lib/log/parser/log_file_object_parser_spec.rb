# frozen_string_literal: true

require 'log_file_object_parser'

describe LogFileObjectParser do

  subject { build(:log_file_object_parser) }

  describe '#default_format' do
    it 'throws a NotImplementedError' do
      expect do
        subject.send(:default_format)
      end.to raise_error(NotImplementedError)
    end
  end

  describe '#attribute_from_string_value' do
    it 'throws a NotImplementedError' do
      expect do
        subject.send(:attribute_from_string_value, 'name', 'value')
      end.to raise_error(NotImplementedError)
    end
  end

  describe '#collection_from_objects' do
    it 'throws a NotImplementedError' do
      expect do
        subject.send(:collection_from_objects, ['test'])
      end.to raise_error(NotImplementedError)
    end
  end

  describe '#object_from_attributes' do
    it 'throws a NotImplementedError' do
      expect do
        subject.send(:object_from_attributes, {})
      end.to raise_error(NotImplementedError)
    end
  end
end
