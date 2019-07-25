# frozen_string_literal: true

class ParsedDeletionEvent
  attr_reader :backup_id, :backup_created_at, :status_code

  def initialize(
    backup_id:,
    backup_created_at:,
    status_code:,
    error_description: ''
  )
    @backup_id = backup_id
    @backup_created_at = backup_created_at
    @status_code = status_code
    @error_description = error_description
  end

  def successful?
    @status_code == 'Removed 200'
  end

  def ==(other)
    same_id = backup_id == other.backup_id
    same_created_at = backup_created_at == other.backup_created_at
    same_id && same_created_at
  end
end
