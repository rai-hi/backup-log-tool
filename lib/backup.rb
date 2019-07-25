# frozen_string_literal: true

require 'loggable'

class Backup
  include Loggable

  attr_reader :id, :created_at, :status, :filesize, :database_name

  def initialize(id:, created_at:, status:, filesize:, database_name:)
    @id = id
    @created_at = created_at
    @status = status
    @filesize = filesize
    @database_name = database_name
  end

  def older_than_days?(days)
    threshold_date = DateTime.now - days
    older = created_at < threshold_date
    return true if older
  end

  def ==(other)
    return true if other.id == @id
  end

  def to_log_string(file_format:)
    logged_fields = [@id, @created_at, @status, @filesize, @database_name]
    logged_fields.join(file_format.delimeter)
  end
end
