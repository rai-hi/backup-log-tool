# frozen_string_literal: true

require 'rest-client'
require 'api_response'

module BackupApiClient
  class << self
    def delete_by_id(id)
      uri = delete_uri(id).to_s
      put_request(uri)
    end

    private

    def put_request(uri)
      RestClient.put(uri, {}) do |raw_response, _request, _result|
        return ApiResponse.new code: raw_response.code, body: raw_response
      end
    end

    def delete_uri(id)
      URI.parse("#{url_prefix}/remove-backup?backup_id=#{id}")
    end

    def url_prefix
      'https://example.com'
    end
  end
end
