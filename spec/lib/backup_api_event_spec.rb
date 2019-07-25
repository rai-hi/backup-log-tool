# frozen_string_literal: true

require 'backup_api_event'

describe BackupApiEvent do
  it_behaves_like 'Loggable'

  let(:backup) do
    build(:backup)
  end

  let(:api_response) do
    api_response = instance_double('ApiResponse')
    allow(api_response).to receive(:code).and_return(200)
    allow(api_response).to receive(:body).and_return("{test: 'response'}")
    api_response
  end

  subject do
    described_class.new(
      backup: backup,
      api_response: api_response
    )
  end

  it '.backup' do
    expect(subject.backup).to eq(backup)
  end

  it '.api_response' do
    expect(subject.api_response).to eq(api_response)
  end

  it '.failure' do
    allow(api_response).to(receive(:failure?).and_return(:failure))
    expect(subject.failure?).to eq(:failure)
  end
end
