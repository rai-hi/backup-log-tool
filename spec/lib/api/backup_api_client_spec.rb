# frozen_string_literal: true

require 'backup_api_client'

describe BackupApiClient do
  let(:id) { 'a810' }
  let(:delete_url) { "https://example.com/remove-backup?backup_id=#{id}" }

  subject { described_class }

  describe  '#delete_by_id' do
    it 'returns an ApiResponse with the correct attributes' do
      stub_request(:put, delete_url)
        .to_return(status: 200, body: 'test_response', headers: {})

      allow(ApiResponse).to(
        receive(:new)
          .with(code: 200, body: 'test_response')
          .and_return(:double)
      )

      expect(subject.delete_by_id(id)).to eq(:double)
    end

    it 'posts to the correct URL' do
      stub_request(:put, delete_url)
        .to_return(status: 200, body: '', headers: {})

      subject.delete_by_id(id)

      assert_requested(:put, delete_url)
    end
  end
end
