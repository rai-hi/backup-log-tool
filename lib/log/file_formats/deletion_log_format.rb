# frozen_string_literal: true

class DeletionLogFormat
  class << self
    def create
      LogFileFormat.new(
        delimeter: '  ',
        ordered_headings: [
          'ID', 'Created at', 'Status code', 'ErrorDescription'
        ]
      )
    end
  end
end
