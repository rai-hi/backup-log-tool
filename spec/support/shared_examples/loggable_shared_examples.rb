# frozen_string_literal: true

shared_examples_for 'Loggable' do
  let(:file_format) do
    format = instance_double('LogFileFormat')
    allow(format).to receive(:delimeter).and_return('  ')
    format
  end

  it '#to_log_string' do
    expect(
      subject.to_log_string(file_format: file_format)
    ).to be_a(String)
  end
end
