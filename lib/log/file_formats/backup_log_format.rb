# frozen_string_literal: true

class BackupLogFormat
  class << self
    def create
      LogFileFormat.new(
        delimeter: '  ',
        ordered_headings: [
          'ID', 'Created at', 'Status', 'Size', 'Database'
        ]
      )
    end
  end
end
