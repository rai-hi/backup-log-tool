# frozen_string_literal: true
require 'loggable'

class BackupApiEvent
  include Loggable

  attr_reader :backup, :api_response

  def initialize(backup:, api_response:)
    @backup = backup
    @api_response = api_response
  end

  def failure?
    @api_response.failure?
  end

  def to_log_string(file_format:)
    body_single_line = @api_response.body.gsub("\n", ' ').dump
    print_fields = [
      @backup.id, @backup.created_at, response_code_string, body_single_line
    ]
    print_fields.join(file_format.delimeter)
  end

  private

  def response_code_string
    response_code = @api_response.code
    code_prefix = response_code == 200 ? 'Success' : 'Error'
    "#{code_prefix} #{response_code}"
  end
end
