# frozen_string_literal: true

shared_examples_for 'LogFileObjectParser subclass' do
  describe '#default_format' do
    it 'implements the method' do
      expect do
        subject.send(:default_format)
      end.to_not raise_error
    end
  end

  describe '#attribute_from_string_value' do
    it 'implements the method' do
      expect do
        subject.send(:attribute_from_string_value, 'name', 'value')
      end.to_not raise_error
    end
  end
  describe '#attribute_from_string_value' do
    it 'implements the method' do
      expect do
        subject.send(:attribute_from_string_value, 'name', 'value')
      end.to_not raise_error
    end
  end
  
  describe '#collection_from_objects' do
    it 'implements the method' do
      expect do
        subject.send(:attribute_from_string_value, 'name', 'value')
      end.to_not raise_error
    end
  end

  describe '#object_from_attributes' do
    it 'implements the method' do
      expect do
        subject.send(:object_from_attributes, {})
      end.to_not raise_error
    end
  end

  # let(:file_format) {
  #   format = instance_double('LogFileFormat')
  #   allow(format).to receive(:delimeter).and_return('  ')
  #   format
  # }

  # it '#to_log_string' do
  #   expect(
  #     subject.to_log_string(file_format: file_format)
  #   ).to be_a(String)
  # end
end
