# frozen_string_literal: true

require 'backup'
require 'api_response'
require 'backup_api_event'
require 'log_file_format'
require 'log_file_object_parser'
require 'parsed_deletion_event'
require 'Date'

FactoryBot.define do
  factory :backup do
    id { 'a810' }
    created_at { DateTime.now - 5 }
    status { 'Completed 2019-07-10 00:18:53 +0000' }
    filesize { '430MB' }
    database_name { 'DATABASE' }

    initialize_with { new(attributes) }
    skip_create
  end

  factory :backup_api_event do
    backup
    api_response

    initialize_with { new(backup: backup, api_response: api_response) }
  end

  factory :api_response do
    code { 200 }
    body { "{'test': 'success'}" }

    initialize_with { new(code: code, body: body) }
  end

  factory :parsed_deletion_event do
    backup_created_at { DateTime.now }
    backup_id { 'a180' }
    status_code { 200 }

    initialize_with do
      new(
        backup_created_at: backup_created_at,
        backup_id: backup_id,
        status_code: status_code
      )
    end
  end

  factory :log_file_format do
    ordered_headings { %w[test two three] }

    initialize_with do
      new(
        ordered_headings: ordered_headings
      )
    end
  end

  factory :log_file_object_parser do
    file_format factory: :log_file_format
     initialize_with do
      new(
        file_format: file_format
      )
    end
  end
end
